function batchToVisualWords(numCores)
    % 
    % CV Fall 2013 - Provided Code
    % Does parallel computation of the visual words
    %
    % Input:
    %   numCores - number of cores to use (default 2)
    % 
    % Modification History:
    %   Xinlei Chen - CV Fall 2013 (Homework 2 - BOW)
    %   Arun Venkatraman - CV Spring 2015 (HW6, upgraded to parpool instead of
    %          matlab pool. Also loads struct-saved images instead of raw 
    %          image files)
    %
    
    if nargin < 1
        %default to 2 cores
        numCores = 2;
    end
    
    %load the files and texton dictionary
    dict = load('dictionary.mat','filterBank','dictionary');
    
    source = '../data/MSRC/';
    target = [source, '../wordmaps/'];
    
    if ~exist(target,'dir')
        mkdir(target);
    end
    
    % get the class names we are looking at
    class_names = load('provided/class_names.mat');
    class_names = class_names.class_names;
    
    
    % Close the pools, if any
   % curr_pool = gcp('nocreate');
   % if (~isempty(curr_pool) && curr_pool.NumWorkers ~= numCores)
   %     delete(curr_pool);
   %     pool = parpool(numCores);
   % end
   % if (isempty(curr_pool))
   %     pool = parpool(numCores);
   % end
   % pool = gcp('nocreate');

    %This is a peculiarity of loading inside of a function with parfor. We need to
    %tell MATLAB that these variables exist and should be passed to worker pools.
    filterBank = dict.filterBank;
    dictionary = dict.dictionary;
    
    l = numel(class_names);
    source_full_fname = strcat(source, '/', class_names);
    for i=1:l
        fprintf('\n(%d/%d): Converting to visual words-- %s\n', i,l, class_names{i});
        images = load(source_full_fname{i});
        images = images.images;
        num_images = numel(images);
        wordmaps = cell(num_images,1);
        for n = 1:num_images
            fprintf(' ..%d/%d\n', n, num_images);
            im = images(n).im;
            wordmaps{n} = getVisualWords(im, filterBank, dictionary);
        end
        for n = 1:num_images
            images(n).wordmap = wordmaps{n};
        end
        out_fname = strcat(target, '/', class_names{i});
        fprintf(' .Saved wordmaps to: %s\n', out_fname);
        saveOutMat(images, out_fname);
    end
    
    %close the pool
    fprintf('Closing the pool\n');
    %delete(pool);
end

function saveOutMat(data, matname)
    save(matname, 'data');
end
