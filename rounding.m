function [ a ] = rounding( z, clips, annot )
%ROUNDING Summary of this function goes here
%   Detailed explanation goes here

l = mat2cell(-2* z', 17, clips);
a = optimize_a(l, annot);
a = cell2mat(a);

end

