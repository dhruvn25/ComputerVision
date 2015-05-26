function [labels, num_labels] = slicSuperPixels( image, num_clusters, compactness)
    %% Given an image, get a superpixel representation as output
    %
    % Input:
    %   image - the image, should be uint8 with values from 0-255 in each
    %           channel. Can be grayscale or color.
    %           image has dimensions [height x width x channels]
    %   num_clusters - Requested number of SLIC clusters. Resuly may be less.
    %   compactness - compactness of superpixel clusters
    % Output:
    %   labels - [height x width] integer labels. Each superpixel has a
    %       unique integer identifier. Call imagesc(labels) to see how it
    %       looks.
    %   num_labels - number of clusters in the superpixel image (labels).
    %           This number is close to, but could be less than, the number
    %           of requested clusters (num_clusters)
    %
    % Modification History:
    %   Arun Venkatraman: CV Spring 2015
    
    %% Parse input arguments
    if isa(image, 'double')
        image = im2uint8(image);
    end
    if any(image(:) < 0) || any(image(:) > 255)
        im_min = min(image(:));
        im_max = max(image(:));
        error('Image should be uint8 between 0-255 in each channel. Found min: %f, max: %f', im_min, im_max)
    end
    
    % set default arguments
    if nargin < 2
        num_clusters = 100;
    end
    if nargin < 3
        compactness = 15;
    end
    %% This section can be modified!
    % example to add parameters for superpixel computing, in this case (SLIC) it is the number of clusters
    [labels, num_labels] = slicmex(image, num_clusters, compactness);%numlabels is the same as number of superpixels
end

