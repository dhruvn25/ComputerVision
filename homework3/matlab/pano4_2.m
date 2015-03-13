% PANO4_2.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
% Warps img2 and img1 to a third frame, display warped version of img2, overlay both images
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
% usage: [H2to1] = pano4_2(img1, img2, pts)

function [H2to1] = pano4_2(img1, img2, pts)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    [h,w,~] = size(img1)
    [h2,w2,~] = size(img2)
    extrema1 = [w2;0;1];
    extrema2 = [w2;h2;1];
    extrema3 = [0;0;1];
    extrema4 = [0;h2;1];
    
    H2to1 = computeH_norm(pts(1:2,:),pts(3:4,:))
    M = [.5 0 0; 0 .5 0; 0 0 1];
    
    translated1 = M*H2to1*extrema1
    translated2 = M*H2to1*extrema2
    translated3 = M*H2to1*extrema3
    translated4 = M*H2to1*extrema4
    translated5 = M*extrema1
    translated6 = M*extrema2
    translated7 = M*extrema3
    translated8 = M*extrema4
    
    xtranslated = [translated1(1)/translated1(3) translated2(1)/translated2(3) translated3(1)/translated3(3) translated4(1)/translated4(3)...
        translated5(1)/translated5(3) translated6(1)/translated6(3) translated7(1)/translated7(3) translated8(1)/translated8(3)];
    ytranslated = [translated1(2)/translated1(3) translated2(2)/translated2(3) translated3(2)/translated3(3) translated4(2)/translated4(3)...
        translated5(2)/translated5(3) translated6(2)/translated6(3) translated7(2)/translated7(3) translated8(2)/translated8(3)];
    xtrans = max(xtranslated) - min(xtranslated)
    ytrans =  max(ytranslated) - min(ytranslated)
    
    M(1,3) = abs(min(xtranslated))
    M(2,3) = abs(min(ytranslated))
    
    newheight = round(ytrans)
    outsize = [newheight,1280];
    warp_im1 = warpH(img1,M,outsize);
    warp_im2 = warpH(img2,M*H2to1,outsize);
    combinedImg = imfuse(warp_im1,warp_im2,'blend');
    imshow(combinedImg);
    

end
