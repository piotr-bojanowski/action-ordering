function [ f ] = compute_f_PL( z )
%SQUARE_LOSS_F Summary of this function goes here
%   Detailed explanation goes here

[N, ~] = size(z);

f = z' * ones(N,1);

end