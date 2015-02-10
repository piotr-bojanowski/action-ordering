function [ a ] = optimize_a( l, annot )
%OPTIMIZE_A Given the loss for all samples and all classes, and the
%annotation sequence, we find the best possible assignment

a = cell(length(l), 1);

for i = 1:length(l)
    % getting the annotation sequence
    k = 17*ones(2*length(annot{i})+1, 1);
   
    % adding "other" labels in between
    k(2:2:end) = annot{i};
    
    % building the cost matrix
    C = l{i}(k, :);
    
    [~, path, ~] = warping_mex(C);
    
    a{i} = full(sparse(path(:, 2), k(path(:, 1)), 1));
end

end