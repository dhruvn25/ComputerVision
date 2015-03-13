% RANSACH.M
% 16-720 Spring 2015 - *Stub* Provided
% Generates a panorama of two images
%
% Arguments: 
%     im1  - first image
%     im2  - second image
%
% Returns: 
%     im3  - generated panorama
%
% usage: im3 = generatePanorama(im1, im2)

function im3 = generatePanorama(im1, im2)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    
    im1gray = im2double(rgb2gray(im1));
    im2gray = im2double(rgb2gray(im2));
    
    im1Features = detectSURFFeatures(im1gray);
    im2Features = detectSURFFeatures(im2gray);

    [features1, valid_points1] = extractFeatures(im1gray, im1Features);
    [features2, valid_points2] = extractFeatures(im2gray, im2Features);

    [indexPairs] = matchFeatures(features1,features2,'MaxRatio',.5);

    matchedPoints1 = valid_points1(indexPairs(:, 1), :);
    matchedPoints2 = valid_points2(indexPairs(:, 2), :);


    S = size(matchedPoints1,1);
    pts1 = [];
    pts2 = [];
    temp1 = [];
    temp2 = [];

    for i = 1:S
       temp1 = [round(matchedPoints1(i).Location)]';
       pts1 = [pts1 temp1];
       temp2 = [round(matchedPoints2(i).Location)]';
       pts2 = [pts2 temp2];
    end

    pts1(3,:) = 1;
    pts2(3,:) = 1;
    newIndexes =[ linspace(1,101,101);linspace(1,101,101)]';
    [H,e,I] = ransacH(newIndexes,pts1,pts2,1000,1);
    [h,w,~] = size(im1);
    [h2,w2,~] = size(im2)
    extrema1 = [w2;0;1];
    extrema2 = [w2;h2;1];
    extrema3 = [0;0;1];
    extrema4 = [0;h2;1];
    extrema5 = [w;0;1];
    extrema6 = [w;h;1];
    extrema7 = [0;0;1];
    extrema8 = [0;h;1];
   
    M = [.5 0 0; 0 .5 0; 0 0 1];
    
    translated1 = M*H*extrema1;
    translated2 = M*H*extrema2;
    translated3 = M*H*extrema3;
    translated4 = M*H*extrema4;
    translated5 = M*extrema5;
    translated6 = M*extrema6;
    translated7 = M*extrema7;
    translated8 = M*extrema8;
    
    xtranslated = [translated1(1)/translated1(3) translated2(1)/translated2(3) translated3(1)/translated3(3) translated4(1)/translated4(3)...
        translated5(1)/translated5(3) translated6(1)/translated6(3) translated7(1)/translated7(3) translated8(1)/translated8(3)];
    ytranslated = [translated1(2)/translated1(3) translated2(2)/translated2(3) translated3(2)/translated3(3) translated4(2)/translated4(3)...
        translated5(2)/translated5(3) translated6(2)/translated6(3) translated7(2)/translated7(3) translated8(2)/translated8(3)];
    xtrans = max(xtranslated) - min(xtranslated);
    ytrans =  max(ytranslated) - min(ytranslated);
    
    M(1,3) = abs(min(xtranslated));
    M(2,3) = abs(min(ytranslated));
    
    outsize = [round(ytrans),round(xtrans)];
    
    
    warp_im1 = warpH(im1,M,outsize);
    warp_im2 = warpH(im2,M*H,outsize);
    combinedImg = imfuse(warp_im1,warp_im2,'blend');
    imshow(combinedImg);
    
    im3 = combinedImg;
    
end
