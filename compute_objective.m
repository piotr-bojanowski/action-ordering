function f = compute_objective(X, z, tau, aleph, kappa, GXTP)
% Computing the objective...

fSL = compute_f_SL(X, z, z, GXTP, aleph);
fPL = compute_f_PL(z);

f   = tau * fSL + kappa' * fPL;

end