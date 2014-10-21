Description
=====================================

This is the code corresponding to the paper Weakly Supervised Action Labeling in Videos Under Ordering Constraints. 
Given videos with associated labels sequences, we find the optimal alignment.
Along the optimization, we train the corresponding action model.

Dependencies
=====================================

There are no external dependencies.

Runing the code
=====================================

To run this code, you need to compile the mex file for the warping code.
```
>> mex('warping_mex.cpp');
```

You also have to provide the path to the data file.
The data fileis can be downloaded from the project webpage:
http://www.di.ens.fr/willow/research/actionordering/

There are two versions: `dataset.mat` and `full_dataset.mat`.
`dataset.mat` contains a specific random split for `seed=5`.
`full_dataset.mat` contains the whole dataset and provides clip indices.
If you use the second one, and specify `seed=5`, you should get the same results.

To run simply type :
```
>> main
```
in the MATLAB comand prompt.
