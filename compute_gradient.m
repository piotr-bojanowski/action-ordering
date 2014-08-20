function grad = compute_gradient(X, z, N, tau, aleph, kappa, GXTP)
% Computing the gradient

gSL = compute_grad_SL(X, z, GXTP, aleph);
gPL = ones(1, N);

grad = tau * gSL + kappa * gPL;

end