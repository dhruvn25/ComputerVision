[filterBank,dictionary] = getFilterBankAndDictionary(image_names,200,90);
save('dictionary','filterBank','dictionary');
batchToVisualWords;
%evaluateKmeans;
evaluateSpectral;