
load('provided/supervised_splits.mat');
addpath('provided/');
source = '../data/wordmaps/';
load('dictionary.mat');
image_names = dir(sprintf('%s*.mat',source));
acc = [];
f =[];

for i=14:length(image_names)
    imageSet = load(sprintf('%s%s',source,image_names(i).name));
    splitString = strsplit(image_names(i).name,'.');
    fprintf('%s \n',splitString{1});
    train_images = splits_map(splitString{1}).train;
    test_images = splits_map(splitString{1}).test;   
    avg = [];
    train_superpixels = [];
     
        for j=1:length(imageSet.data)
            if(find(str2num(imageSet.data(j).num)==train_images))
                %it is train data
                wm = imageSet.data(j).wordmap;
                [labels, num_labels] = slicSuperPixels(imageSet.data(j).im, 300, 30);
                
                label_struct = valuesPerLabel(wm,labels);
                histograms = arrayfun(@(x) hist(label_struct(x).values,length(dictionary)),linspace(1,length(label_struct),length(label_struct)),'UniformOutput',0);
                h = reshape(cell2mat(histograms),[length(dictionary),length(label_struct)])';
                for m=1:size(h,1)
                    h(m,:) = h(m,:)/sum(h(m,:));
                end
                gt_struct = valuesPerLabel(imageSet.data(j).gt,labels);
                for k=1:size(gt_struct,2)
                    ratio = sum(gt_struct(k).values)/length(gt_struct(k).values);
                    if(ratio>=.9)
                        %positive superpixel
                        %fprintf('positive superpixel %d\n',k);
                        train_superpixels = [train_superpixels; h(k,:) 1];
                    elseif(ratio<=.1)
                        %negative superpixel
                        %fprintf('negative superpixel %d\n',k);
                        train_superpixels = [train_superpixels; h(k,:) 0];
                    end
                end
                
            end
        end
        %train a learning algo
        modelknown = fitcknn(train_superpixels(:,1:(end-1)),train_superpixels(:,end));
        %run for test
        testnum = 1;
        for j=1:length(imageSet.data)
            if(find(str2num(imageSet.data(j).num)==test_images))
                %it is train data
                wm = imageSet.data(j).wordmap;
                [labels, num_labels] = slicSuperPixels(imageSet.data(j).im, 300, 30);
                
                label_struct = valuesPerLabel(wm,labels);
                histograms = arrayfun(@(x) hist(label_struct(x).values,length(dictionary)),linspace(1,length(label_struct),length(label_struct)),'UniformOutput',0);
                h = reshape(cell2mat(histograms),[length(dictionary),length(label_struct)])';
                for m=1:size(h,1)
                    h(m,:) = h(m,:)/sum(h(m,:));
                end
                %put histo into the algo
                predicted_labels = predict(modelknown,h);
                predicted_image = zeros(size(wm));
                for k=1:length(predicted_labels)
                   if(predicted_labels(k))
                       predicted_image = predicted_image + label_struct(k).mask;
                   end
                end
                if (i == 14)
                    im_out = im2double(rgb2gray(imageSet.data(j).im)).*predicted_image;
                    imshow(im_out);
                    pause;
                end
                imagesc(predicted_image);
                pause(.01);
                [accuracy(testnum),f1(testnum)] = evaluateImFGBG(imageSet.data(j).gt,predicted_image,1);
                testnum = testnum + 1;
            end
        end
        acc = [acc;mean(accuracy)]
        f = [f;mean(f1)];
        accuracy = [];
        f1 = [];
        % save(sprintf('%s-supervised',splitString{1}),'accuracy','f1','model');
        
end
% figure; bar(acc);
% figure; bar(f);
% 
% figure;
% errorbar(graph_vals(:,1),graph_vals(:,2),'.');
% hold on;
% bar(graph_vals(:,1))
% hold off;
% figure;
% errorbar(graph_vals(:,3),graph_vals(:,4),'.');
% hold on;
% bar(graph_vals(:,3))
% hold off;

figure; bar(acc-graph_vals(:,1));
title('Accuracy')
figure; bar(f-graph_vals(:,3));
title('F1');
[mean(acc-graph_vals(:,1)) (acc-graph_vals(:,1))']
[mean((f-graph_vals(:,3))) (f-graph_vals(:,3))']