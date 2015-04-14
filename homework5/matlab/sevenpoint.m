function [ F ] = sevenpoint( pts1,pts2,M )
%UNTITLED2 Summary of this function goes here
%   pts 7 x 2
%   M scale factor

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

for i=1:7
    row = x1(i,:)'*x2(i,:);
    row = row(:)';
    A(i,:) = row;
    
end

[U S V] = svd(A);
F_1i = reshape(V(:,end),[3 3]);
F_2i = reshape(V(:,(end-1)),[3 3]);

% [U S V] = svd(F_init);
% V(3,3) = 0;
% F_rank = U*S*V';
syms l Fs;

Fs = (1-l)*F_1i + l*F_2i;
eqn = det((1-l)*F_1i + l*F_2i) == 0;
solL = solve(eqn,l);

%check for imaginary parts greater than 1e-15 or something

%do for all solutions
for i =1:size(solL,1)
    F_init = real( double((1-solL(1)))*F_1i + double(solL(1))*F_2i);

    F_unnorm = refineF(F_init,x1,x2);

    F{i} = transpose(NormalMatrix)*F_unnorm*NormalMatrix;

end

end

