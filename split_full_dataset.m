function [ X, Y, annot, hw3, Xtest, Ytest ] = split_full_dataset( datapath )
%SPLIT_FULL_DATASET Summary of this function goes here
%   Detailed explanation goes here

load(datapath);

% converting to a block matrix
X = cell2mat(X);
X = double(X);

% getting the sequence annotations
annot = {hw3.actid};

% choose the classification test set
clips = cellfun(@(x) size(x, 1), Y);
[test, test_idx] = get_test(Y, clips, 0.1);

% removing the test set from data
Ytest = cell2mat(Y(test));
Xtest = X(test_idx, :);
Y(test) = [];
annot(test) = [];
hw3(test) = [];
X(test_idx, :) = [];

end

