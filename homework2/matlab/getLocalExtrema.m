% DOGDETECTOR.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     DoGPyramid         - Matrix of size (height x width x m)
%     DoGLevels          - Vector with m elements
%     PrincipalCurvature - Matrix of size (height x width x m)
%     th_contrast        - scalar threshold for DoG image
%     th_r               - scalar threshold for principal curvature
% Returns: 
%     locs - N-by-3 matrix where N is the number of local extrema found and
%            each row contains the (x,y) position and the corresponding
%            DoGLevel number. 
%
% usage: locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)

function locs = getLocalExtrema(DoGPyramid, DoGLevels, ... 
                                PrincipalCurvature, th_contrast, th_r)
                            
    % TODO: STUDENT IMPLEMENTATION GOES HERE

end
