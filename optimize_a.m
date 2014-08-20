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
    
    
%     [gt_path_x, gt_path_y] = find(gt{i}(:, k));
    
    [D, path] = warping_mex(C);
    
%     if verbose
%         clf;
%         subplot(1,2,1);
%         imagesc(C);
%         subplot(1,2,2);
%         imagesc(D);
%         s = sort(D(:), 'descend');
%         caxis([0, s(find(s<9900, 1))]);
%         hold on;
%         scatter(gt_path_x, gt_path_y, 500, [1,1,1], '.');
%         scatter(path(:, 2), path(:, 1), 100, [0,0,0], '.');
%         hold off;
%         drawnow;
%         waitforbuttonpress();
%     end
    
    a{i} = full(sparse(path(:, 2), k(path(:, 1)), 1));
end

end