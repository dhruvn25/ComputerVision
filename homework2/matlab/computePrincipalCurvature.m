% COMPUTEPRINCIPALCURVATURE.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     DoGPyramid - Matrix of size (height x width x m)
% Returns: 
%     PrincipalCurvature - A matrix of size (height x width x m) where each
%                          element represents the curvature ratio for each
%                          corresponding point in the DoG pyramid.
%
% usage: PrincipalCurvature = computePrincipalCurvature(DoGPyramid))


function [PrincipalCurvature] = computePrincipalCurvature(DoGPyramid)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    [r,c,d] = size(DoGPyramid);
    PrincipalCurvature = zeros(r,c,d);
    for n=1:d
        [FX,FY] = gradient(DoGPyramid(:,:,n));
        [FXX,FYX] = gradient(FX);
        [FXY,FYY] = gradient(FY);
        
        
                
        pc  = ((FXX+FYY).^2)./(FXX.*FYY - FXY.*FXY);
      
        PrincipalCurvature(:,:,n) = pc;
%         for row=1:r
%             for column=1:c
%                 H = [FXX(r,c) FYX(r,c); FXY(r,c) FYY(r,c)];
%                 PrincipalCurvature(r,c,n) = trace(H)^2 / det(H);
%                 %pc(r,c) = R;
%             end
%         end
    
    end
    
    
end
