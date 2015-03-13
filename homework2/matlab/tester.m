image1 = '../data/model_chickenbroth.jpg';
im = im_to_gray(image1);

levels = [-1 0 1 2 3 4];
sigma0 = 1;
k = sqrt(2);
th_r = 12;
th_contrast = 0.03;
[r,c] = size(im);


GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
%displayPyramid(GaussianPyramid);

[DGP, DGL] = createDoGPyramid(GaussianPyramid, levels);
%displayPyramid(DGP);
PR = computePrincipalCurvature(DGP);

locs = getLocalExtrema(DGP, DGL, PR, th_contrast, th_r);
    
%[locs,GP] = DoGdetector(grey_image1,sigma0,k, levels, th_contrast,th_r);
displayPyramid(DGP);
hold on;
plot(locs(:,1)+locs(:,3)*c,locs(:,2),'ro');

pause;
close all;