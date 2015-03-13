% COMPUTEH_NORM.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
% This version normalizes the input coordinates p1 and p2 prior to calling
% compute_H() to find the actual homography. The normalizaiton scales the
% points so that the average distance to the mean of the original points is
% sqrt(2).
%
% Arguments: 
%     p1    - 2xN matrix with (x,y)^T image coordinates for image 1
%             N is the number of points.
%     p2    - 2xN matrix with (x,y)^T image coordinates for image 2
%             Each point (column) in p2 corresponds with the respective
%             column in p1
% Returns: 
%     H2to1 - 3x3 homography matrix computed from p1 and p2. It is the best
%             fit given p1 and p2 in the least-squares sense.
%
% usage: [H2to1] = computeH_norm(p1, p2)


function [H2to1] = computeH_norm(p1, p2)
    % TODO: STUDENT IMPLEMENTATION GOES HERE

    centroid1 = mean(p1');
    centroid2 = mean(p2');
    
    cent1 = repmat(centroid1',1,length(p1));
    cent2 = repmat(centroid2',1,length(p2));
    
%     p1centered(1,:) = p1(1,:) - centroid1(1);
%     p1centered(2,:) = p1(2,:) - centroid1(2);
% 
%     p2centered(1,:) = p2(1,:) - centroid2(1);
%     p2centered(2,:) = p2(2,:) - centroid2(2);

    p1centered = p1 - cent1;
    p2centered = p2 - cent2;
    
    dist1 = sqrt(p1centered(1,:).^2 + p1centered(2,:).^2);
    dist2 = sqrt(p2centered(1,:).^2 + p2centered(2,:).^2);
    
    scale1 = sqrt(2) / mean(dist1);
    scale2 = sqrt(2) / mean(dist2);
    
    scaleMatrix1 = [scale1 0 -scale1*centroid1(1); 0 scale1 -scale1*centroid1(2); 0 0 1];
    scaleMatrix2 = [scale2 0 -scale2*centroid2(1); 0 scale2 -scale2*centroid2(2); 0 0 1];
    
    p1cscaled = scaleMatrix1*[p1;ones(size(p1,2),1)'];
    p2cscaled = scaleMatrix2*[p2;ones(size(p2,2),1)'];
    
%     p1cscaled = p1centered.*scale1;
%     p2cscaled = p2centered.*scale2;
    
    
    H2to1 = computeH(p1cscaled,p2cscaled);
    
    H2to1 = inv(scaleMatrix1)*H2to1*scaleMatrix2;
   
%     scaleMatrix = [1/scale2 1/scale2 1; 1/scale2 1/scale2 1; 1/(scale1*scale2) 1/(scale1*scale2) 1/scale1]
%     
%     H2to1 = scaleMatrix.*H2to1;
%     size(H2to1)
%     size([p1;ones(1,length(p1))])
%     ones(1,length(p1))
%     H2to1*[p1; ones(1,length(p1))]
%     p2
%     scale = (H2to1*[p1; ones(1,length(p1))])/p2
%     H2to1 = H2to1 / scale(1);

end
