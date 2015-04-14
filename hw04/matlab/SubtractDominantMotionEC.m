function [ moving_image,moved_objects ] = SubtractDominantMotionEC( image1,image2,moved_objects )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
   
   M = LucasKanadeAffine(image1,image2);
%    [Xq,Yq] = meshgrid(linspace(1,size(image1,2),size(image1,2)),linspace(1,size(image1,1),size(image1,1)));
%    oldX = [Xq(:) Yq(:) ones(size(Yq(:)))]';
%    newX = M*oldX;
%    %[Xq2,Yq2] = meshgrid(newX(1,:),newX(2,:));
%    Xq2 = reshape(newX(1,:),size(Xq));
%    Yq2 = reshape(newX(2,:),size(Xq));
%    
%    IW = interp2(image1,Xq2,Yq2);
   iw2 = imwarp(image1,affine2d(M'),'OutputView',imref2d(size(image1)));
   %sum(sum(IW-iw2))
   warpedmask = imwarp(ones(size(image1)),affine2d(M'),'OutputView',imref2d(size(image1)));
   diff = image2.*warpedmask -iw2;
   
   %moving_image = abs(diff)>80;
 
   moving_image = hysthresh(abs(diff),80,20);

   if(~sum(size(moved_objects)))
       indexes = find(moving_image);
       if(sum(indexes(:)))
           objects = [indexes(1)];
       threshold = 241;
       lastindex = indexes(1);
       firstindex = indexes(1);
       for i = 2:length(indexes)
           if indexes(i)>lastindex+threshold
               moved_objects = [moved_objects; firstindex lastindex];
               firstindex = indexes(i);
               lastindex = indexes(i);
           else
               lastindex = indexes(i);
           end
           
       end
       moved_objects
       %moved_objects = moving_image;
   else
       %find all the moving objects in moving image
       %moved_objects = hysthresh(abs(diff),81,79);
       %moving_image2 = moved_objects==moving_image;
       %%moved_objects = moving_image;
       %moving_image = moving_image2;
   end
   
end