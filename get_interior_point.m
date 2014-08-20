function z = get_interior_point(N, K, clips, annot)
%This function aims at finding an interior point to start the FW
%optimization.

z = zeros(N, K);
for i = 1:2
    zTA = rand(K, N);
    l = mat2cell(zTA, K, clips);
    a = optimize_a(l, annot);
    a = cell2mat(a);
    z = z + a;
end
z = z/2;

end