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
    [cx_y,cx_x] = ind2sub([9 9],compareX);
    [cy_y,cy_x] = ind2sub([9 9],compareY);
    
    
    desc = [];
    final_locs = [];
    for i=1:length(locs)
        x = locs(i,1);
        y = locs(i,2);
        
        if ( min(cx_x) + x > 0 && min(cy_x) + x > 0 && ...
             min(cx_y) + y > 0 && min(cy_y) + y > 0 && ...
             max(cx_x) + x < size(im,2) && max(cy_x) + x < size(im,2) && ...
             max(cx_y) + y < size(im,1) && max(cy_y) + y < size(im,1))
                
            this_desc = zeros(length(compareX),1);
            for n=1:length(compareX)
                this_desc(n) = im(y + cx_y(n),x + cx_x(n)) < im(y + cy_y(n),x + cy_x(n));
            end
            desc = [desc; this_desc'];
            final_locs = [final_locs; locs(i,:)];
        end
    end
        
    locs = final_locs; 
    
end