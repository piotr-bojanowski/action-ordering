function [ GXTP ] = compute_GXTP( X, lambda )
%COMPUTE_GXTP Summary of this function goes here
%   Detailed explanation goes here

[N, d] = size(X);

XTP = bsxfun(@plus, X, -mean(X, 1))'; 

G = XTP * X + N * lambda * eye(d);

% G = zeros(d, d);
% 
% for i = 1:d
%     fprintf('column %5d\n', i);
%     G(:, i) = XTP * X(:, i);
% end
% 
% G = G + N * lambda * eye(d);

GXTP = G \ XTP;

% GXTP = bsxfun(@times, GXT, 1./sum(GXT, 2));

end