function gama_opt=compute_gamma_optimal_FW(X, z, a, GXTP, tau, aleph, kappa)

gama_n = 2 * tau * compute_f_SL(X, z  , z-a, GXTP, aleph) + ...
    kappa' * compute_f_PL(z-a);


gama_d = 2 * tau * compute_f_SL(X, a-z, a-z, GXTP, aleph);

gama = gama_n / gama_d;

gama_opt = max(min(gama, 1), 0);

end