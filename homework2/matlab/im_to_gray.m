function [grey_image] = im_to_gray(image)
img = im2double(imread(image));

grey_image = rgb2gray(img);

end