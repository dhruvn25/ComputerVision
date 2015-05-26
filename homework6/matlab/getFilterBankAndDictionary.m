function [filterBank, dictionary] = getFilterBankAndDictionary(image_names,pixelnum,K)
% 16720 CV Spring 2015 - Stub Provided
% Inputs: 
%   image_names: cell array of strings (full path to images)
% Outputs:
%   filterBank:  a cell array of N filters
%   dictionary:  \alpha x K matrix 

source = '../data/MSRC/';


%save only 50-150 pixels
%pixelnum = 100;
%K = 80;

%get filterbank
filterBank = createFilterBank();
%saved_filter_bank = zeros(length(image_names)*pixelnum,60);
saved_filter_bank = [];
%get images and filter responses
%length(image_names)
for i=1:length(image_names)
    
    imageSet = load(sprintf('%s%s',source,image_names(i).name));
    for j=1:length(imageSet.images)
        
        image = imageSet.images(j).im;
        filter_responses = extractFilterResponses(image, filterBank);
        randpixel = randperm(length(filter_responses),pixelnum);

        saved_filter_bank = [saved_filter_bank; filter_responses(randpixel,:)];

        %smaller_filter_responses = reshape(filter_responses(randpixel,:),[1,pixelnum*60]);


        %saved_filter_bank(i,:) = smaller_filter_responses;
    end
end


[r,c,d,e] = size(saved_filter_bank)


%implement K mean
[~,dictionary] = kmeans(saved_filter_bank, K,'EmptyAction','drop');


