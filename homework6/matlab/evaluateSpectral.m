clear;
addpath('provided/');
source = '../data/wordmaps/';
load('dictionary.mat');
image_names = dir(sprintf('%s*.mat',source));
close all;
figure;
for i=1:length(image_names)
    imageSet = load(sprintf('%s%s',source,image_names(i).name));
    avg = [];
        for j=1:length(imageSet.data)
            wm = imageSet.data(j).wordmap;
            [labels, num_labels] = slicSuperPixels(imageSet.data(j).im, 300, 30);
                
    
            %imagesc(labels);
            %pause(.01);
                label_struct = valuesPerLabel(wm,labels);

                histograms = arrayfun(@(x) hist(label_struct(x).values,length(dictionary)),linspace(1,length(label_struct),length(label_struct)),'UniformOutput',0);
                h = reshape(cell2mat(histograms),[length(dictionary),length(label_struct)])';
                for m=1:size(h,1)
                    h(m,:) = h(m,:)/sum(h(m,:));
                end
                
                %affinity = pdist2(h,h,@(x,y) pdistChiSq(x,y));
                %affinity = pdist2(h,h,'correlation');
                affinity = 1 - pdist2(h,h,'cosine');
                labels_out = spectralCluster(affinity,2);
                if ( max(labels_out(:)) - min(labels_out(:)) ~= 1)
                    fprintf('did not get 2: %d %d\n',max(labels_out(:)),min(labels_out(:)));
                    if (max(labels_out(:)) == min(labels_out(:)))
                        labels_out(1,1) = min(labels_out(:))+1;
                    end
                end
                %translate back into the image size
                labels_shape = labels_out(labels+1);
                if (max(labels_shape(:) == 2))
                    labels_shape = labels_shape -1;
                end
                [accuracy,f1] = evaluateImFGBG(imageSet.data(j).gt,labels_shape,0);
           
            
            fprintf('iteration numbers %d %d\n',i,j);
            avg = [avg; mean(accuracy) mean(f1)];
            img = im2double(rgb2gray(imageSet.data(j).im));
            out_im = img.*labels_shape;
            
            imshow(out_im);
           
            pause(.01);
            %imagesc(labels_shape);
            %pause(.1);
        end
     image_names(i).name
     accuracy = mean(avg(:,1));
     acc_std = std(avg(:,1));
     f1 = mean(avg(:,2));
     f1_std = std(avg(:,2));
     
     graph_vals(i,:) = [accuracy acc_std f1 f1_std];
     %acc_list(i) = struct('name',image_names(i).name,'acc',accuracy,'f1',f1);
end
save('spectral-graphvals','graph_vals');
figure;
errorbar(graph_vals(:,1),graph_vals(:,2),'.');
hold on;
bar(graph_vals(:,1))
hold off;
figure;
errorbar(graph_vals(:,3),graph_vals(:,4),'.');
hold on;
bar(graph_vals(:,3))
hold off;