function [ test, test_idx ] = get_test( Y, clips, S )
%GET_TEST_SET Summary of this function goes here
%   Detailed explanation goes here

% building the index from clips to samples
N = sum(clips);
clip_idx = mat2cell((1:N)', clips);

% getting the action presence indicator for every clip
C = cellfun(@(x) sum(x, 1)>0, Y, 'UniformOutput', false);
C = cell2mat(C);

[test, ~] = split_set(C, S);

% converting clip idx to sample idx
test_idx = cell2mat(clip_idx(test));

end