clc;
clear;
close all;
load('../data/bookSequence.mat');
rect = [247, 102, 285, 161];
rectB = [247, 102, 285, 161];
[r c l n] = size(sequence);
box = rect;
for i = 1:(n-1)
    i
    im1 = sequence(:,:,:,i);
    im2 = sequence(:,:,:,i+1);
    
     
    
    [u,v] = LucasKanadeBasis(im1,im2,rectB,basis);
    

    
    rectB(1) = (rectB(1) + u);
    rectB(2) = (rectB(2) + v);
    
    rectB(3) = (rectB(3) + u);
    rectB(4) = (rectB(4) + v);
    
    [u,v] = LucasKanade(im1,im2,rect);
    
    rect(1) = (rect(1) + u);
    rect(2) = (rect(2) + v);
    
    rect(3) = (rect(3) + u);
    rect(4) = (rect(4) + v);
    
    imshow(im1); 
     hold on;
       rectangle('Position',[rect(1),rect(2),rect(3)-rect(1),rect(4)-rect(2)],'EdgeColor','yellow');
       
       rectangle('Position',[rectB(1),rectB(2),rectB(3)-rectB(1),rectB(4)-rectB(2)],'EdgeColor','blue');
     hold off;
       pause(.001);
           
        if(i == 29 || i == 149 || i == 247)
           pause(1);
           %pause(.001);
        end
     box = [box; rectB];
end
save('bookPosition.mat');
