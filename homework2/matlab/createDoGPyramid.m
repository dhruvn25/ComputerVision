% CREATEDOGPYRAMID.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     GaussianPyramid - Matrix of size (height x width x num_levels)
%     levels          - Vector with num_levels elements
% Returns: 
%     DoGPyramid - A matrix representing the DoG pyramid. Should have
%                  dimensions (height x width x num_levels - 1)
%     DoGLevels  - A vector 
%
% usage: [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)


function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
    % TODO: STUDENT IMPLEMENTATION GOES HERE

    for n = 1:(length(levels)-1)
        DoGPyramid(:,:,n) = GaussianPyramid(:,:,n+1) - GaussianPyramid(:,:,n);        
    end
    %DoGLevels = levels(2:length(levels));
    DoGLevels = levels(1:length(levels) - 1);
end
