function out_im = overlayClasses(src_im, labels, alpha)
    % Overlays colors for each label on top of gray scaled source im 
    % Arguments:
    %   src_im - image (w * h * num_channels) to overlay
    %   labels - labels image (w * h) where each pixel represents the
    %           class/label for that pixel. Each label is an integer index
    %           and will be assigned a color.
    %   alpha  - blending between original image and colorized labels
    %           image (higher means more src_im intensity).
    % Returns:
    %   out_im - image (w * h * 3) image with overlayed label colors
    %
    % Modification History:
    %   Arun Venkatraman, CV Spring 2015: Init commit
    
    if nargin < 3
        alpha = 0.6;
    end

    classes = sort(unique(labels));
    if (numel(classes) > 2)
        colors = lines(numel(classes));
    else
        colors = hsv(numel(classes));
    end
    
    if size(src_im,3) == 3
        gray_im = rgb2gray(im2double(src_im));
    elseif size(src_im,3) == 1
        gray_im = src_im;
    else 
        error('src_im should be a rgb or gray scale im');
    end
    
    out_im = repmat(gray_im, 1,1,3) * alpha;
    
    for m = 1:numel(classes)
        mask = labels == classes(m);
        for n = 1:3
            im = out_im(:,:,n);
            im(mask) = im(mask) + colors(m,n) * (1-alpha);
            out_im(:,:,n) = im;
        end
    end
       
end