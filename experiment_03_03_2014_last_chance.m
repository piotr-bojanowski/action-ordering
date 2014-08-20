%
% params.real_data        = true;
% params.gama_optimal     = true;
% params.niter            = 200;
% params.experiment_name  = 'experiment_03_03_2014_last_chance';
% params.root_dir         = '/sequoia/data1/bojanows/ECCV2014';
% % params.root_dir         = '.';
% params.save_name        = 'sprintf(''a%4.2e_l%4.2e_k%4.2e_s%02d_S%4.2f.mat'', aleph, lambda, kappa0, seed, S)';
%
% feat        = {'hof'};
% tau         = num2cell(1);
% aleph       = num2cell(logspace(0,6,4));
% lambda      = num2cell(logspace(-6,-1,3));
% mu          = num2cell(0);
% alpha       = num2cell(1);
% beta        = num2cell(1);
% dmax        = num2cell(2);
% smooth_bg   = num2cell(false);
% kappa0      = num2cell([0, logspace(-7, -1, 9)]);
% kappa_bckg  = num2cell(1);
% seed        = num2cell(1:5);
% S           = num2cell(linspace(0,1,6));
%
% % experiment( feat{1}, tau{1}, aleph{1}, lambda{1}, mu{1}, alpha{1}, beta{1}, dmax{1}, ...
% %     smooth_bg{1}, kappa0{1}, kappa_bckg{1}, seed{1}, S{1}, params );
%
% global APT_PARAMS;
% APT_params();
% APT_PARAMS.exec_name = 'derniere_chance';
% APT_compile();
%
% APT_run('experiment', feat, tau, aleph, lambda, mu, alpha, beta, dmax, smooth_bg, kappa0, kappa_bckg, seed, S, {params}, ...
%     'Memory', 4600, ...
%     'ClusterID', 2, ...
%     'CombineArgs', 1, ...
%     'GroupBy', 1);
%
%
% save('experiment_03_03_2014_last_chance.m');

%%

load('results/experiment_03_03_2014_last_chance.mat');

jac_val = zeros(length(aleph), length(lambda), length(kappa0), length(seed), length(S));

for i = 1:length(aleph)
    for j = 1:length(lambda)
        for k = 1:length(kappa0)
            for u = 1:length(seed)
                for v = 1:length(S)
                    fprintf('%d %d %d %d %d\n', i,j,k,u,v);
                    fname = sprintf('a%4.2e_l%4.2e_k%4.2e_s%02d_S%4.2f.mat', aleph{i}, lambda{j}, kappa0{k}, seed{u}, S{v});
                    path = fullfile(params.root_dir, params.experiment_name, fname);
                    temp = load(path, 'perf_val');
                    jac_val(i,j,k,u,v) = temp.perf_val(end).jacquard_pred_nobg;
                end
            end
        end
    end
end

%Get the optimal values of the parameters

for v = 1:length(S)
        jac_temp = squeeze(jac_val(:,:,:,:,v));
        [~, idx] = max(jac_temp(:));
        [i,j,k,u] = ind2sub(size(jac_temp), idx);
        fprintf('Optimal parameters values for S=%4.2f are aleph = %4.2e, lambda = %4.2e, kappa0 = %4.2e, seed = %d \n', S{v}, aleph{i}, lambda{j}, kappa0{k}, seed{u})
end
load('./splits.mat');
%%

test_jac = zeros(length(seed), length(S));
test_jac_per_class = zeros(length(S), 16, length(seed));
classif = zeros(length(seed), length(S));
classif_per_class = zeros(length(S), 17, length(seed));

for u = 1:length(seed)
    for v = 1:length(S)
        jac_temp = squeeze(jac_val(:,:,:,u,v));
        [~, idx] = max(jac_temp(:));
        [i,j,k] = ind2sub(size(jac_temp), idx);
        fname = sprintf('a%4.2e_l%4.2e_k%4.2e_s%02d_S%4.2f.mat', aleph{i}, lambda{j}, kappa0{k}, seed{u}, S{v});
        path = fullfile(params.root_dir, params.experiment_name, fname);
        temp = load(path, 'y', 'z', 'z_p', 'clips', 'perf_classif');
        
        new_perf = evaluate(temp.z(splits(u,v).test_idx, :), ...
            temp.y(splits(u,v).test_idx, :), ...
            temp.z_p(splits(u,v).test_idx, :), ...
            temp.clips(splits(u,v).test));
        
        test_jac(u,v) = new_perf.jacquard_pred_nobg;
        test_jac_per_class(v, :, u) = new_perf.jac_per_class;
        
        classif(u,v) = temp.perf_classif.map;
        classif_per_class(v, :, u) = temp.perf_classif.ap;
    end
end

m_jac = mean(test_jac, 1);
v_jac = std(test_jac, 1, 1) ./ sqrt(length(seed));

m_test_jac_per_class = mean(test_jac_per_class, 3);
v_test_jac_per_class = std(test_jac_per_class, 1, 3) ./ sqrt(length(seed));

m_classif = mean(classif, 1);
v_classif = std(classif, 1, 1) ./ sqrt(length(seed));

m_classif_per_class = mean(classif_per_class, 3);
v_classif_per_class = std(classif_per_class, 1, 3) ./ sqrt(length(seed));

save('../final_result_our.mat', 'm_*', 'v_*', 'S');



