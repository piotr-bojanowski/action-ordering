
params.niter    = 200;

tau         = 1;
aleph       = 1;
lambda      = 3.16e-4;
kappa0      = 1e-7;
seed        = 5;
S           = 0;


% if using the pre-split dataset, load this file
% the dataset.mat file contains a precomputed split (seed=5)
% datapath = '/YOUR_PATH_HERE/dataset.mat';

% if using the full dataset, load this file, the split will be carried out
% that way you can use various splits
datapath = '/YOUR_PATH_HERE/full_dataset.mat';

[perf_val, perf_test, perf_classif, obj] = experiment( datapath, tau, ...
    aleph, lambda, kappa0, seed, S, params );
