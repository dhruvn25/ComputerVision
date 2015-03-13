im1 = imread('../data/taj1r.jpg');
im2 = imread('../data/taj2r.jpg');

% im1g = im2double(rgb2gray(im1));
% im2g = im2double(rgb2gray(im2));

load('../data/tajPts.mat');
plotMatches(im1g,im2g,tajPts);

 H = pano4_1(im1,im2,tajPts)
% save('../results/q4_1.mat','H');
%H = pano4_2(im1,im2,tajPts);