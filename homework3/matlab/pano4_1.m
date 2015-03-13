% PANO4_1.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
% Warps img2 to img1's frame, display warped version of img2, overlay both images
%
% Arguments: 
%     img1  - first image
%     img2  - second image
%     pts   - 4x1048 matrix containing coordianates of feature points
%             first 2 columns are for img1, second 2 columns are for img2
% Returns: 
%     H2to1 - 3x3 homography matrix computed from img1 and img2. It is the best
%             fit given pts from img1 and img2 in the least-squares sense.
%
% usage: [H2to1] = pano4_1(img1, img2, pts)

function [H2to1] = pano4_1(img1, img2, pts)
    % TODO: STUDENT IMPLEMENTATION GOES HERE

    H2to1 = computeH_norm(pts(1:2,:),pts(3:4,:));
    im2W = warpH(img2, H2to1, [size(img1,1),3000]);
    figure;imshow(im2W);
    
    imout = imfuse(img1,im2W,'blend');
    figure;imshow(imout);
    
end
