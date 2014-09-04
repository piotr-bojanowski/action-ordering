
params.niter    = 200;

tau         = 1;
aleph       = 1;
lambda      = 3.16e-4;
kappa0      = 1e-7;
seed        = 5;
S           = 0;

datapath = '/sequoia/data1/bojanows/ECCV2014/code-clean/dataset.mat';

[perf_val, perf_test, perf_classif, obj] = experiment( datapath, tau, ...
    aleph, lambda, kappa0, seed, S, params );
