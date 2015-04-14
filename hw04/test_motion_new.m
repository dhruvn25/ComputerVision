% TEST_MOTION.M
% test_motion makes a movie (motion.avi) using the sequence of binary
% images returned after every call of SubtractDominantMotion function
%
% Modification History:
%   10/12/12  - 16-720 Fall 2012 TAs: Original file
%   3/23/15 - Arun Venkatraman: Moved to VideoWriter as avifile is deprecated in 2014b.
%


path_to_images = '../data/Sequence1';
numimages = 21;

% add a trailing slash to the path if needed:
if(path_to_images(end) ~= '/' & path_to_images(end) ~= '\')
    path_to_images(end+1) = '/';
end
if ~exist(path_to_images, 'dir')
    error(['Cannot found directory: ', path_to_images])
end

fname = sprintf('%s//frame%d.pgm',path_to_images,0);

if ~exist(fname, 'file')
    error(['Cannot found file: ', fname])
end

img1 = double(imread(fname));

% create movie object
video_fname = [pwd(), filesep, 'motion.avi'];
vidObj = VideoWriter(video_fname);
vidObj.Quality = 100;
vidObj.FrameRate = 7;

vidObj.open()

% resize the frames before storing as output
out_size_cols = 640;

Fs = cell(1, numimages);

try
    for frame = 1 : numimages-1
        % Reads next image in sequence
        fname = sprintf('%s//frame%d.pgm',path_to_images,frame);
        
        img2 = double(imread(fname));
        
        % Runs the function to estimate dominant motion
        display(sprintf('(%d/%d): Processing im pair %d and %d', frame, numimages-1,frame-1,frame));
        [motion_img] = subtractDominantMotion(img1, img2);
        % Superimposes the binary image on img2, and adds it to the movie
        currframe = repmat(img2 / 255.0, [1 1 3]);
        motion_img = double(motion_img);
        temp=img2/255.0; temp(motion_img~=0.0)=1.0;
        currframe(:,:,1)=temp;
        currframe(:,:,3)=temp;
        
        resized_frame = imresize(currframe, [nan, out_size_cols]);
        resized_frame(resized_frame < 0) = 0;
        resized_frame(resized_frame > 1) = 1;
        
        % save frome to movie
        vidObj.writeVideo(resized_frame);
        Fs{frame} = currframe;
        
        % Prepare for processing next pair
        imshow(uint8(currframe));
        img1 = img2;
    end
    % close the file
    vidObj.close();
catch ME
    % In case an error occurs, it's a good idea to close the avi object
    % handle before exiting. Otherwise MATLAB complains when you try
    % to open the file again in future.
    disp(ME)
    vidObj.close();
    return;
end

% Success!
disp('Done!')
% Use the OS to try and play the movie
if ismac
    cmd = 'open'; % use default app
    system([cmd, ' ', video_fname]);
elseif isunix % should work on most linux distros
    cmd = 'xdg-open'; % use default program
    system([cmd, ' ', video_fname]);
elseif ispc
    % untested. may not work
    cmd = 'C:\Program Files\Windows Media Player\wmplayer.exe /play'; % windows media player
    status = system([cmd, ' ', video_fname]);
    if status ~= 0
        warning('Automatic starting of playback may not be working on windows...Try playing it manually from windows media player.')
    end
end
