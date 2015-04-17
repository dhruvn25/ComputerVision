load('../data/templeCoords.mat');
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load('../data/some_corresp.mat');
F = eightpoint(pts1,pts2,max(size(im1)));
M1 = [eye(3) zeros(3,1)];
findM2;

for i=1:size(x1,1)
   [x2(i),y2(i)] = epipolarCorrespondence(im1,im2, F, x1(i),y1(i));
end

P = triangulate(M1,[x1 y1], M2, [x2' y2']);
