function montage_im = displayPyramid( pyramid, fig_h )
    %DISPLAYPYRAMID Plots an image pyramid matrix 
    % 16-720 Spring 2015 - Provided Code
    %        Arun Venkatraman (arunvenk@cs.cmu.edu) | Feburary 9, 2015
    % 
    % Visualizes each image in an image pyramid 
    % (height x width x numImages) for Grayscale/bw and
    % (height x width x 3 x numImages) for RGB
    %
    % ARGUMENTS:
    %    pyramid - the pyramid as described above
    %    fig_h   - figure handle to draw the figure in (optional)
    % RETURNS:
    %    montage_im - image of the montaged pyramid.
    %                 Rescaled to [0,1] for writing to file.
    %
    % usage: displayPyramid(pyramid, fig_h)
    
    if ((nargin < 2) || isempty(fig_h))
        fig_h = figure();
    else
       figure(fig_h);
    end
    ax_h = gca;

    pyramid_dims = ndims(pyramid);
    if (pyramid_dims == 4) % rgb pyramid
        to_show = pyramid;
        num_images = size(pyramid, 4);    
        
        m_h = montage(to_show, 'Parent', ax_h, 'Size', [1, num_images]);
    elseif (pyramid_dims == 3) || (pyramid_dims == 2) % grayscale pyramid
        [height, width, num_images] = size(pyramid);
        to_show = zeros([height, width, 1, num_images]); 
        to_show(:, :, 1, :) = pyramid;
        
        m_h = montage(to_show, 'Parent', ax_h, 'Size', [1, num_images], 'DisplayRange', [min(to_show(:)), max(to_show(:))]);
    else
        error('''pyramid'' has incorrect number of dimensions');
    end
       
    axis(ax_h, 'on');
    
    if nargout >= 1
        montage_im = rescaleImage(get(m_h, 'cdata'));
    end
  
end

function imrs = rescaleImage(im)
    imrs = im - min(im(:));
    imrs = imrs ./ max(imrs(:));
end