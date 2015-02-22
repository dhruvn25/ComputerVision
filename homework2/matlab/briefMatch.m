% BRIEFMATCH.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     desc1, desc2 - m-by-nbits, matrix of stacked BRIEF descriptors. 
%                    m is the number of valid descriptors. 
%                    desc1 is from the first image, desc2 is from the second
%     ratio        - Ratio value for the ratio test to suppress bad matches
% Returns: 
%     matches - p-by-2 matrix, where the first column are indices into desc1 
%               and the second column are indices into desc2.
% usage: [matches] = briefMatch(desc1, desc2, ratio)

function [matches] = briefMatch(desc1, desc2, ratio)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    
    [D,I] = pdist2(desc1,desc2,'hamming','smallest',2);
    matches = [];
    size(desc1)
    size(desc2)
%     desc1
%     desc2
    [r,c] = size(D)
    D(:,1)
    for i=1:size(D,2)
        if D(1,i) < ratio*D(2,i)
            matches = [matches; I(1,i) i];
        end
    end
    
      
end