clc;
clear;
close all;
load('../data/bookSequence.mat');
rect = [247, 102, 285, 161];
[r c l n] = size(sequence);
for i = 1:(n-1)
    i
    im1 = sequence(:,:,:,i);
    im2 = sequence(:,:,:,i+1);
    
%     if(i == 20 || i == 50 || i == 100)
%        imshow(im1); hold on;
%        rectangle('Position',[rect(1),rect(2),rect(3)-rect(1),rect(4)-rect(2)]);
%        plot(rect(1),rect(2),'bO');
%        plot(rect(3),rect(4),'bO');
%        hold off;
%        pause;
%        %pause(.001);
%     end
    
    [u,v] = LucasKanadeBasis(im1,im2,rect,basis);
    
    rect(1) = (rect(1) + u);
    rect(2) = (rect(2) + v);
    
    rect(3) = (rect(3) + u);
    rect(4) = (rect(4) + v);
    
    
    
end
