function [grey_image] = im_to_gray(image)
img = im2double(imread(image));
size(img)
if (size(img,3) == 3)
    grey_image = rgb2gray(img);
else
    grey_image = img;
end
end