function [ idx1, idx2 ] = split_set( C, S )
%SPLIT_SET Summary of this function goes here
%   Detailed explanation goes here

[N, K] = size(C);
P = 10000;

dmin = inf;

for i = 1:P
    perm = randperm(N);
    n = round(N*S);
    
    t1 = perm(1:n);
    t2 = perm((n+1):end);
    
    if numel(t1)==0
        h1 = zeros(1, K);
    else
        h1 = sum(C(t1, :), 1);
        h1 = h1 / sum(h1);
    end
    
    if numel(t2)==0
        h2 = zeros(1, K);
    else
        h2 = sum(C(t2, :), 1);
        h2 = h2 / sum(h2);
    end
    
    d = sum(sqrt(abs(h1-h2)))^2;
    
    if d<dmin
        idx1 = t1;
        idx2 = t2;
        dmin = d;
    end
end

end

