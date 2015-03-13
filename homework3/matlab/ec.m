%load images
im1 = imread('../results/ec1.jpg');
im2 = imread('../results/ec2.jpg');
im3 = imread('../results/ec3.jpg');
%im4 is fuse of 1 and 2;
im4 = generatePanorama(im1,im2);


%im5 is fuse of 3 and 4;

im5 = generatePanorama(im4,im3);

