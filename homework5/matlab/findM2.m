load('../data/intrinsics.mat');
load('../data/some_corresp.mat');
im1 = imread('../data/im1.png');
F = eightpoint(pts1,pts2,max(size(im1)));
E = essentialMatrix(F,K1,K2);
M2s = camera2(E);

%P1 = [eye(3) zeros(3,1)']*K1;
M1 = [eye(3) zeros(3,1)];
%pick an M
best = 0;
for i=1:4
    
    P = triangulate(M1,pts1,M2s(:,:,i),pts2);
    %P2 = K2*M2s(:,:,i);
    %pts1(1,:);
%     reproj = P2*P;
%     reproj = reproj / reproj(3);
%     sum((pts2 - reproj(1:2,:)').^2)
    %P = P/P(4,:);
    if (sum((P(3,:)>0)) == size(pts1,1))
        M2 = M2s(:,:,i);
    end
end


