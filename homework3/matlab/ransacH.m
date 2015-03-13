% RANSACH.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes homogaphy using ransac
%
% Arguments: 
%     matches  - matches between locs1 and locs2
%     locs1    - feature points in img1
%     locs2    - feature points in img2
%     nIter    - number of iterations for RANSAC
%     tol      - tolerance for a point to be an inlier
% Returns: 
%     bestH    - homography that has the most inliers
%     bestError- error value of the bestH
%     inliers  - vector of 1's and 0's matching the vector matches, where 1 is inliers
%
% usage: [bestH, bestError, inliers] = ransacH(matches, locs1, locs2, nIter, tol)

function [bestH, bestError, inliers] = ransacH(matches, locs1, locs2, nIter, tol)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    %matches is Nx2
    %locs are 3xN
    if nargin < 5
        tol = 3;
    end
    if nargin < 4
        nInter = 100;
    end
    bestH = eye(3);
    bestError = 100;
    bestInliers = 0;
    thisError = 0;
    for i=1:nIter
        %randomly pick 4 points
%         size(locs1)
        idx = randperm(size(matches,1),4);
        %matches(idx,1);
%         size(locs1)
        size(locs1(:,matches(idx,1)));
        size(locs2(:,matches(idx,2)));

        H = computeH_norm(locs1(1:2,matches(idx,1)),locs2(1:2,matches(idx,2)));
        thisInliers = zeros(size(locs1,2),1);
        for l=1:size(locs1,2)
           guess1 = H*[locs2(1:2,l);1];
           guessDistance = sqrt((guess1(1)/guess1(3) - locs1(1,l))^2 + (guess1(2)/guess1(3)-locs1(2,l))^2);
          
           if guessDistance  < tol
                thisInliers(l) = 1;
           end
           thisError  = thisError + guessDistance;
               
        end
        
        if sum(thisInliers(:)) > bestInliers
            bestH = double(H);
            bestInliers = sum(thisInliers(:));
            bestError = thisError;
        end
        
    end
   
    inliers = bestInliers;
end
    