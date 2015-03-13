% COMPUTEH.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
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
% usage: [H2to1] = computeH(p1, p2)


function [H2to1] = computeH(p1, p2)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    
    %size(p1)
    
    A = [-p2(1,:)' -p2(2,:)' -ones(size(p2(2,:)')) zeros(size(p2(2,:)')) zeros(size(p2(2,:)')) zeros(size(p2(2,:)')) ...
        p1(1,:)'.*p2(1,:)' p1(1,:)'.*p2(2,:)' p1(1,:)';
        zeros(size(p2(2,:)')) zeros(size(p2(2,:)')) zeros(size(p2(2,:)')) -p2(1,:)' -p2(2,:)' -ones(size(p2(2,:)'))...
        p1(2,:)'.*p2(1,:)' p1(2,:)'.*p2(2,:)' p1(2,:)'];
    
    [U S V] = svd(A);
    %V = V'
    h = V(:,9);
     
    H2to1 = [h(1) h(2) h(3); h(4) h(5) h(6); h(7) h(8) h(9)];
    %H2to1 = H2to1 / H2to1(3,3);
    
end
