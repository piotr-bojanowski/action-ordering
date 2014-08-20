function [D, path] = warping(C)
% WARPING This function finds the optimal path for a given cost matrix C

[m, n] = size(C);

% adding zeros top and left of C
C = cat(1, zeros(1, n), C);
C = cat(2, zeros(m+1, 1), C);

% creating the cumulative cost matrix
D = zeros(size(C));

% filling it with prohibitive values on the borders
D(1, 2:end) = inf;
D(2:end, :) = inf;

for i = 1:m
    for j = 1:n
        [m, id] = min([D(i+1,j), D(i,j)]);
        D(i+1, j+1) = C(i+1, j+1) + m;
    end
end


D(1,:) = inf;
D(:, 1) = inf;

% starting at the end of the matrix
[i,j] = size(D);
path = [i,j];

% while not at the fake corner
while i>1 && j>1
    
    % find the minimum
    [~, id] = min([D(i-1,j-1), D(i,j-1)]);
    if id == 1
        i = i-1;
        j = j-1;
    elseif id == 2
        j = j-1;
    end
    
    % add the min step to the path
    path = cat(1, [i,j], path);
end

% remove last step, and decrement by one
path = path(2:end, :) - 1;
D = D(2:end, 2:end);


end