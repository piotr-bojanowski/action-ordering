function [ res, res1, res2 ] = jacquard( bb1,bb2 )
%OVERLAP Computes the overlap matrix of the two set of bounding boxes. The
%resulting matrix is of the following form 
% 
%                         bb2
%                      ______________
%                     |              |
%                     |              |
%                bb1  |              |
%                     |              |
%                     |              |
%                     |______________|


m = size(bb1,1);

res = zeros(m,1);
res1 = zeros(m,1);
res2 = zeros(m,1);

for i = 1:m
    [res(i), res1(i), res2(i)] = box_overlap(bb1(i,:),bb2(i,:));
end


end

