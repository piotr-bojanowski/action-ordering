function [ z, z_p, w, b, perf_val, perf_test, obj ] = frank_wolfe_optimization( ...
    X, y, clips, annot, z, sup_idx, val_idx, test_idx, val, test, ...
    tau, aleph, lambda, kappa, params )

[N, ~] = size(X);

% pre-computing heavy stuff
GXTP = compute_GXTP(X, lambda);
L = sparse(N, N);

% enforcing supervision
z(sup_idx, :) = y(sup_idx, :);

% computing the gradient
grad = compute_gradient(X, z, N, tau, aleph, kappa, GXTP);

perf_val    = evaluate();
perf_test   = evaluate();
obj         = struct('f', [], 'd', [], 't', []);

tic;

for i = 1:params.niter
    
    % cutting the gradient into clips
    l = mat2cell(grad, 17, clips);
    
    % performing the Dynamic Programing
    a = optimize_a(l, annot);
    a = cell2mat(a);

    % adding the supervision (can be seen as additional constraints on W)
    a(sup_idx, :) = y(sup_idx, :);

    % Linearization duality gap
    d = trace(grad*(z-a));
    
    % getting the optimal step size
    gama = compute_gamma_optimal_FW(X, z, a, GXTP, tau, aleph, kappa);
    
    % updating z
    z = (1-gama) * z + gama * a;
    
    % computing objective value
    f = compute_objective(X, z, tau, aleph, kappa, GXTP);
    
    % computing the gradient
    grad = compute_gradient(X, z, N, tau, aleph, kappa, GXTP);
    
    % rebuilding the classifiers
    w = GXTP * z;
    b = ones(1, N) * (z - X * w) / N;
    
    % rounding
    z_p = rounding(z, clips, annot);
    
    % evaluating
    perf_val(i)     = evaluate(z(val_idx, :), y(val_idx, :), z_p(val_idx, :), clips(val));
    perf_test(i)    = evaluate(z(test_idx, :), y(test_idx, :), z_p(test_idx, :), clips(test));
    
    % keeping track of the objective
    obj(i).f = f;
    obj(i).d = d;
    obj(i).t = toc;
    
    % printing the score
    fprintf('iter=%3i f=%-+5.3e ', i, f);
    fprintf('dgap=%-+5.3e ', d);
    fprintf('acc=%5.3f ', perf_test(i).acc);
    fprintf('p=%5.3f ', perf_test(i).precision);
    fprintf('r=%5.3f ', perf_test(i).recall);
    fprintf('jac=%5.3f ', perf_test(i).jacquard);
    fprintf('jac_pred_nobg=%5.3f ', perf_test(i).jacquard_pred_nobg);
    fprintf('map=%5.3f \n', perf_test(i).map);

end



end