function [ f ] = compute_f_SL( X, z1, z2, GXTP, aleph )
%SQUARE_LOSS_F Summary of this function goes here
%   Detailed explanation goes here


zzTA = 0.5 * compute_grad_SL(X, z1, GXTP, aleph) * z2;

f = trace(zzTA);

end