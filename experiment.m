function [perf_val, perf_test, perf_classif, obj] = experiment( datapath, tau, ...
    aleph, lambda, kappa0, seed, S, params )
% Main experimental script: lambda is the regularization parameter of the model
% mu is the tradeoff in the model between discriminative term and grouping
% (NC, see paper for details)
% kappa0 is a term enforcing non trivial solution
% S belongs to [0,1] and is the portion of annotated data you want

rng(seed);

[~, dataname, ~] = fileparts(datapath);
switch dataname
    case 'dataset'
        load(datapath);
    case 'full_dataset'
        % load the full dataset and split it according to the chosen seed
        % hw3 contains the indexes of the corresponding clips
        [X, Y, annot, hw3, Xtest, Ytest] = split_full_dataset(datapath);
end

% concatenating the labels
y       = cell2mat(Y);

% getting the size of every clip
clips   = cellfun(@(x) size(x, 1), Y);

% getting the size of all the data
[N, K]  = size(y);

% initializing with an interior point
z = get_interior_point(N, K, clips, annot);

% setting parameters
kappa = kappa0 * [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 1]';

% choosing supervised set
[~, val, test, sup_idx, val_idx, test_idx] = get_sup_val(Y, clips, S);

% launching the optimization
[z, z_p, w, b, perf_val, perf_test, obj] = frank_wolfe_optimization(...
    X, y, clips, annot, z, sup_idx, val_idx, test_idx, val, test, ...
    tau, aleph, lambda, kappa, params);

% getting test classification performance
z_test = Xtest * w;
perf_classif = evaluate(z_test, Ytest);


end
