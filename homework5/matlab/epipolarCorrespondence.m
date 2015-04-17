function [x2, y2] = epipolarCorrespondence(im1, im2, F, x1, y1)
windowSize = 60;
im1 = im2double(rgb2gray(im1));
im2 = im2double(rgb2gray(im2));

x1list = linspace((x1-round(windowSize/2)),(x1+round(windowSize/2)),(windowSize+1));
y1list = linspace((y1-round(windowSize/2)),(y1+round(windowSize/2)),(windowSize+1));
[Xq,Yq] = meshgrid(x1list,y1list);
intensity1(:,:,1) = interp2(double(im1(:,:,1)),Xq,Yq);
%intensity1(:,:,2) = interp2(double(im1(:,:,2)),Xq,Yq);
%intensity1(:,:,3) = interp2(double(im1(:,:,3)),Xq,Yq);

%intensity1 = im1((y1-round(windowSize/2)):(y1+round(windowSize/2)), (x1-round(windowSize/2):(x1+round(windowSize/2))));
x2best = 1;
y2best = 1;

epipolarM = F*[x1;y1;1];
bestDiff = 100000;
syms x y;
%eqn = [x y 1]*epipolarM == 0;
% solXY = solve(eqn, [x y]);
%figure;
%subplot(1,2,1);
%imshow(im1);
%hold on;
%plot(x1,y1,'bO');
%hold off;
%subplot(1,2,2);
%imshow(im2);
%hold on;
%lines = epipolarLine(F,[x1 y1]);
for i=1:.2:size(im1,1)
    
   x2 = -1*(epipolarM(2)*i + epipolarM(3))/epipolarM(1);
   
   if(x2 <= size(im1,2) && x2 >= 1)
       y2 = i;
       %plot(x2,y2,'rO');
    %check window
    x2list = linspace((x2-round(windowSize/2)),(x2+round(windowSize/2)),(windowSize+1));
    y2list = linspace((y2-round(windowSize/2)),(y2+round(windowSize/2)),(windowSize+1));
    [Xq,Yq] = meshgrid(x2list,y2list);
    intensity2(:,:,1) = interp2(double(im2(:,:,1)),Xq,Yq);
    %intensity2(:,:,2) = interp2(double(im2(:,:,2)),Xq,Yq);
    %intensity2(:,:,3) = interp2(double(im2(:,:,3)),Xq,Yq);

    diff = abs(intensity1-intensity2);
    difference = sum(diff(:)) + abs(x2^2 - x1^2) + abs(y2^2-y1^2);
    if (difference < bestDiff)
        x2best = x2;
        y2best = y2;
        bestDiff = difference;
    end
   end
   
end
%plot(x2best,y2best,'gO');
%hold off;
x2 = x2best;
y2 = y2best;
end