function [res] = evaluate(z, y, z_p, clips)

if nargin == 0
    res = [];
    res.acc = [];
    res.recall = [];
    res.precision = [];
    res.r_per_class = [];
    res.p_per_class = [];
    res.f1_per_class = [];
    res.jacquard            = [];
    res.jacquard_nobg       = [];
    res.jacquard_pred       = [];
    res.jacquard_pred_nobg  = [];
    res.jac_per_class = [];
    res.jac_per_clip = [];
    res.mean_jac_per_clip = [];
    res.ap = [];
    res.map = [];
    return
    
elseif nargin == 2
    
    [~, K] = size(y);

    res = [];    
    res.ap = zeros(1, K);

    for i = 1:K
        [~, ~, info] = vl_pr(2*y(:, i)-1, z(:, i));
        res.ap(i) = info.auc_pa08;
    end

    res.map = mean(res.ap);
    
    return
else

    [~, K] = size(y);
    [~, gt] = max(y, [], 2);

    res = [];    

    [~, pred] = max(z_p, [], 2);

    res.acc = sum(pred==gt) / length(gt);
    res.recall = sum(pred==gt & gt~=K) / sum(gt~=K);
    res.precision = sum(pred==gt & gt~=K) / sum(pred~=K);

    res.r_per_class = zeros(1, K);
    res.p_per_class = zeros(1, K);
    for i = 1:K
        res.r_per_class(i) = sum(pred==gt & gt==i) / sum(gt==i);
        res.p_per_class(i) = sum(pred==gt & gt==i) / sum(pred==i);
    end
    
    r = res.r_per_class;
    p = res.p_per_class;
    idxr = isnan(r) | r==0;
    idxp = isnan(p) | p==0;
    
    res.r_per_class(idxr) = 0;
    res.p_per_class(idxp) = 0;
    
    res.f1_per_class = 2 * r.*p ./ (r+p);
    res.f1_per_class(idxr|idxp) = 0;
    
    [gt, j, ~, j_pred, j_perclip, gt_perclip] = all_jacquards(z_p, y, clips);
    
    res.jacquard            = mean(j);
    res.jacquard_nobg       = mean(j(gt~=17));
    res.jacquard_pred       = mean(j_pred);
    res.jacquard_pred_nobg  = mean(j_pred(gt~=17));
    
    res.jac_per_class = zeros(1, K-1);
    for i = 1:K-1
        res.jac_per_class(i) = mean(j_pred(gt==i));
    end
    
    res.jac_per_clip = j_perclip;
    res.mean_jac_per_clip = zeros(length(j_perclip), 1);
    for i = 1:length(j_perclip)
        res.mean_jac_per_clip(i) = mean(j_perclip{i}(gt_perclip{i} ~= 17));
    end
    
    res.ap = zeros(1, K);
    
    for i = 1:K
        [~, ~, info] = vl_pr(2*y(:, i)-1, z(:, i));
        res.ap(i) = info.auc_pa08;
    end

    res.map = mean(res.ap);
    
    return
end

end