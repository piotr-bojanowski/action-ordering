function [ res, res1, res2 ] = box_overlap( bb1, bb2 )
% Given two bounding boxes, this function computes the overlap. It is valid
% only for a single couple of boxed. Lists of boxes are treated by the
% function overlap.m in which box_overlap function is called multiple
% times.


% computing intersection
interx = min( bb1(2) , bb2(2) ) - max( bb1(1) , bb2(1) ) + 1;
inter = max(0,interx);

% computing union
union = ( bb1(2) - bb1(1) + 1 ) + ( bb2(2) - bb2(1) + 1 ) - inter;

% getting the overlap is straightforward

res = inter / union;
res1 = inter / (bb1(2) - bb1(1) + 1);
res2 = inter / (bb2(2) - bb2(1) + 1);

end

