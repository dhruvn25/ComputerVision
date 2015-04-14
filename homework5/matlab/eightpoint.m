function [ F ] = eightpoint(pts1, pts2, M)
%UNTITLED Summary of this function goes here
%   pts are N x 2 matricies of (x,y) points
%   M is a scale factor


NormalMatrix = [(1/M) 0 0; 0 (1/M) 0; 0 0 1];

x1 = pts1 ;
x2 = pts2 ;

x1(:,3) = 1;
x2(:,3) = 1;

x1 = NormalMatrix*x1';
x2 = NormalMatrix*x2';

x1 = x1';
x2 = x2';

[r c] = size(x1);
A = zeros(r,9);

for i=1:size(A,1)
    row = x1(i,:)'*x2(i,:);
    row = row(:)';
    A(i,:) = row;
    
end

[U S V] = svd(A);
F_init = reshape(V(:,end),[3 3]);

% [U S V] = svd(F_init);
% V(3,3) = 0;
% F_rank = U*S*V';

F_unnorm = refineF(F_init,x1,x2);

F = transpose(NormalMatrix)*F_unnorm*NormalMatrix;

end


