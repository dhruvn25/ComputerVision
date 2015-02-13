% COMPUTEBRIEF.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     im                 - a grayscale image with range 0 to 1
%     locs               - keypoints from the DoG detector
%     levels             - Gaussian scale levels from Section 1
%     compareX, compareY - Linear indices into the image patch (nbits x 1)
% Returns: 
%     locs - m-by-3 matrix, where the first two columns are the image
%            coordinates of keypoints and the third column is the pyramid
%            level of the keypoints
%     desc - m-by-nbits, matrix of stacked BRIEF descriptors. 
%            m is the number of valid descriptors
% usage: [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)

function [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
end