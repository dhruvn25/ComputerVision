clc;
clear;
close all;
path_to_images = '../data/Sequence1';
numimages = 21;

% test_motion makes a movie (motion.avi) using the sequence of binary 
% images returned after every call of SubtractDominantMotion function

% add a trailing slash to the path if needed:
% if(path_to_images(end) ~= '/' & path_to_images(end) ~= '\')
%     path_to_images(end+1) = '/';
% end

% NOTE - you might have to change the path slashes depending on windows or unix.

fname = sprintf('%s//frame%d.pgm',path_to_images,0);

img1 = double(imread(fname));
fname = sprintf('%s//frame%d.pgm',path_to_images,1);

img2 = double(imread(fname));
movIm = SubtractDominantMotion(img1,img2);
%M = LucasKanadeAffine(img1,img2);