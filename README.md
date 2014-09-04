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

You also have to provide the path to the data file (dataset.mat).
The data file can be downloaded from the project webpage:
http://www.di.ens.fr/willow/research/actionordering/

To run simply type :
```
>> main
```
in the MATLAB comand prompt.
