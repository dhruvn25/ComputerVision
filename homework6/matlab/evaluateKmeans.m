clear;
source = '../data/wordmaps/';
load('dictionary.mat');
image_names = dir(sprintf('%s*.mat',source));
graph_vals = [];
for i=11:length(image_names)
    imageSet = load(sprintf('%s%s',source,image_names(i).name));
    avg = [];
        for j=1:length(imageSet.data)
            wm = imageSet.data(j).wordmap;
            %figure; imshow(imageSet.data(j).im);
            %pause(.01);
            [labels, num_labels] = slicSuperPixels(imageSet.data(j).im, 300, 30);
            for m=1:10
                labels_out = wordmapKmeans(wm,length(dictionary),labels,2);
                if ( max(labels_out(:)) - min(labels_out(:)) ~= 1)
                    fprintf('did not get 2: %d %d\n',max(labels_out(:)),min(labels_out(:)));
                    if (max(labels_out(:)) == min(labels_out(:)))
                        labels_out(1,1) = min(labels_out(:))+1;
                    end
                end
                [accuracy(m),f1(m)] = evaluateImFGBG(imageSet.data(j).gt,labels_out,0);
            end
            
            fprintf('iteration numbers %d %d\n',i,j);
            avg = [avg; mean(accuracy) mean(f1) ];
            
            %imagesc(labels_out);
            %imshow(imageSet.data(j).im);
            img = im2double(rgb2gray(imageSet.data(j).im));
            if( max(labels_out(:)) == 2)
                labels_out = labels_out - 1;
            end
            out_im = img.*labels_out;
            
            imshow(out_im);
            if (i == 11)
                pause;
            end
            pause(.01);
        end
     image_names(i).name
     accuracy = mean(avg(:,1));
     acc_std = std(avg(:,1));
     f1 = mean(avg(:,2));
     f1_std = std(avg(:,2));
     
     graph_vals(i,:) = [accuracy acc_std f1 f1_std];
     %acc_list(i) = struct('name',image_names(i).name,'acc',accuracy,'f1',f1);
end
figure;errorbar(graph_vals(:,1),graph_vals(:,2),'.');
hold on;
bar(graph_vals(:,1))
hold off;
figure;
errorbar(graph_vals(:,3),graph_vals(:,4),'.');
hold on;
bar(graph_vals(:,3))
hold off;
