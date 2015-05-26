function [labels_out] = wordmapKmeans(wordmap, num_words, labels, k)
%num words is size of dictionary
%labels is slic image
%k is number of kmeans clusters to find

label_struct = valuesPerLabel(wordmap,labels);

histograms = arrayfun(@(x) hist(label_struct(x).values,num_words),linspace(1,length(label_struct),length(label_struct)),'UniformOutput',0);
h = reshape(cell2mat(histograms),[num_words,length(label_struct)])';

labels_belonging = kmeans(h,k,'distance','cosine');
%[labels_dictionary,labels_belonging] = k_means(h, k);

%norm_dict = [labels_dictionary(1,:)/sum(labels_dictionary(1,:)); labels_dictionary(2,:)/sum(labels_dictionary(2,:))];

% for i=1:length(label_struct)
%     tempH = h(i,:)/sum(h(i,:));
%     
%     %firstComp = pdist2(tempH,norm_dict(1,:),'cosine'); secondComp =
%     %pdist2(tempH,norm_dict(2,:),'cosine'); firstComp =
%     %sum(sqrt(tempH).*sqrt(norm_dict(1,:))); secondComp =
%     %sum(sqrt(tempH).*sqrt(norm_dict(2,:))); firstComp =
%     %distChiSq(tempH,labels_dictionary(1,:)); secondComp =
%     %distChiSq(tempH,labels_dictionary(2,:));
%     firstComp = distChiSq(tempH,norm_dict(1,:));
%     secondComp = distChiSq(tempH,norm_dict(2,:));
%     if (firstComp > secondComp)
%         labels_class(i) = 0;
%     else
%         labels_class(i) = 1;
%     end
% end

for r=1:size(labels,1)
    for c=1:size(labels,2)
        labels_out(r,c) = labels_belonging(labels(r,c)+1);
        
    end
end

end