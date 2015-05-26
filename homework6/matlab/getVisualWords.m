function wordMap = getVisualWords(I, filterBank, dictionary)
% 16720 CV Spring 2015 - Stub Provided
% Inputs: 
%   I:     RGB Image with dimensions Rows x Cols (e.g. ouput from calling imread)
%   filterBank: Output from getFilterBankAndDictionary()
%   dictionary: Output from getFilterBankAndDictionary()
% Outputs:
%   wordMap:  matrix with dimensions Rows x Cols
filterResponses = extractFilterResponses(I,filterBank);
[h,w,d] = size(I);
wordMap = zeros(h,w);


%smaller_filter_responses = reshape(filterResponses,[1,length(filterResponses)*60]);
%[h,w,d,e]= size(dictionary)
%[hf,wf,df,ef] = size(filterResponses)


 mindist = pdist2(filterResponses,dictionary);
 
%[hm,wm,dm,em] = size(mindist);

[M,I] = min(mindist,[],2);
%mindist
wordMap = reshape(I,[h,w]);