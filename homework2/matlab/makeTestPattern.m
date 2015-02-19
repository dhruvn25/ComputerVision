% MAKETESTPATTERN.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     patchWidth - Width of image patch (usually 9)
%     nbits      - Number of tests in the BRIEF descriptor (usually 256)

% Returns: 
%     compareX, compareY - Linear indices into the image patch (nbits x 1)
%
% usage: [compareX, compareY] = makeTestPattern(patchWidth, nbits)
function [compareX, compareY] = makeTestPattern(patchWidth, nbits)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    
    
    
    %Uniform Distro
    compareX = round(-(patchWidth^2)/2 + [(patchWidth^2)]*rand(nbits,1));
    compareY = round(-(patchWidth^2)/2 + [(patchWidth^2)]*rand(nbits,1));
    
    
    
end