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
    
    [r,c,d] = size(DoGPyramid);
    locs = [];
    for l=1:d
        for x=1:c
            for y=1:r      
                miny = y - 3;
                minx = x -3;
                maxy = y + 3;
                maxx = x +3;
                if (miny < 1)
                    miny = 1;
                end
                if (minx < 1)
                    minx = 1;
                end
                if (maxy > r)
                    maxy = r;
                end
                if (maxx > c)
                    maxx = c;
                end
                
                miniPyramid = DoGPyramid(miny:maxy,minx:maxx,l);
                
                scaleAbove = l - 1;
                if (scaleAbove < 1)
                    scaleAbove = 1;
                end
                scaleBelow = l + 1;
                if (scaleBelow < 1)
                    scaleBelow = 1;
                elseif (scaleBelow > d)
                        scaleBelow = d;
                end
                
                scaleNeighbors = [DoGPyramid(y,x,scaleAbove) DoGPyramid(y,x,scaleBelow) DoGPyramid(y,x,l)];
                
                if ((DoGPyramid(y,x,l) == max(miniPyramid(:))) && (DoGPyramid(y,x,l) == max(scaleNeighbors)))
                    if (abs(DoGPyramid(y,x,l)) > th_contrast)
                        if (abs(PrincipalCurvature(y,x,l)) <= th_r)
                            locs = [locs; x y DoGLevels(l)];
                        end
                    end
                end
            end
        end
    end
    
    
    
end
