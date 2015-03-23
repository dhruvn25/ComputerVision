clc;
clear;
close all;
rect = [328, 213, 419, 265];
load('../data/carSequence.mat');
[r c l n] = size(sequence);
for i = 1:(n-1)
    im1 = sequence(:,:,:,i);
    im2 = sequence(:,:,:,i+1);
    
    %if(i == 20 || i == 50 || i == 100)
       imshow(im1); hold on;
       plot(rect(1),rect(2),'bO');
       plot(rect(3),rect(4),'bO');
       hold off;
       pause;
    %end
    
    [u,v] = LucasKanade(im1,im2,rect);
    
    rect(1) = rect(1) + u;
    rect(2) = rect(2) + v;
    
    rect(3) = rect(3) + u;
    rect(4) = rect(4) + v;
    
    
    
end

