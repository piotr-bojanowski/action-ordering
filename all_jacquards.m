function [ GT, J, J_gt, J_pred, J_perclip, gt_perclip ] = all_jacquards( z_p, y, clips )
%ALL_JACQUARDS Summary of this function goes here
%   Detailed explanation goes here

Y = mat2cell(y, clips, 17);
ZP = mat2cell(z_p, clips, 17);

J       = cell(length(Y), 1);
J_gt    = cell(length(Y), 1);
J_pred  = cell(length(Y), 1);
GT      = cell(length(Y), 1);

for i = 1:length(Y);

    % getting the prediction intervals
    [~, gt] = max(Y{i}, [], 2);
    bp_gt = find(diff(gt)~=0); % computing the break point
    igt = cat(2, cat(1, 1, bp_gt+1), cat(1, bp_gt, length(gt)));
    gt = gt(igt(:, 1));

    % getting the GT intervals
    [~, pred] = max(ZP{i}, [], 2);
    bp_pred = find(diff(pred)~=0); % computing the break point
    ipred = cat(2, cat(1, 1, bp_pred+1), cat(1, bp_pred, length(pred)));
    pred = pred(ipred(:, 1));

    % computing the matching between Gt and pred
    pred2gt = zeros(length(gt), 1);
    k = 1;
    for j = 1:length(gt)
        pred2gt(j) = k + find(pred(k:end)==gt(j), 1, 'first') - 1;
        k = pred2gt(j)+1;
    end
    
    % computing the JACQUARDS!!!!!!!
    [J{i}, J_gt{i}, J_pred{i}] = jacquard(igt, ipred(pred2gt, :));
    GT{i} = gt;
    
end

gt_perclip = GT;
J_perclip = J_pred;
GT      = cell2mat(GT);
J       = cell2mat(J);
J_gt    = cell2mat(J_gt);
J_pred  = cell2mat(J_pred);


end

