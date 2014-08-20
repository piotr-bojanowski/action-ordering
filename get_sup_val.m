function [ sup, val, test, sup_idx, val_idx, test_idx ] = get_sup_val( Y, clips, S )
%GET_INITIAL_SET computing the RANDOM set of clips used for initialization

% building the index from clips to samples
N = sum(clips);
clip_idx = mat2cell((1:N)', clips);

% getting the action presence indicator for every clip
C = cellfun(@(x) sum(x, 1)>0, Y, 'UniformOutput', false);
C = cell2mat(C);

% getting the train and the rest
[train, nontrain] = split_set(C, 0.5);

% getting the supervised set
[idx, ~] = split_set(C(train, :), S);
sup = train(idx);

% getting the val and test set
[idx1, idx2] = split_set(C(nontrain, :), 0.1);
val = nontrain(idx1);
test = nontrain(idx2);

% converting clip idx to sample idx
sup_idx = cell2mat(clip_idx(sup));
val_idx = cell2mat(clip_idx(val));
test_idx = cell2mat(clip_idx(test));

end