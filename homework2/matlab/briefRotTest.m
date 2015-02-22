image1 = '../data/model_chickenbroth.jpg';
image2 = '../data/model_chickenbroth.jpg';

matchnums = zeros(36,1);
for i=1:36
    
    grey_image1 = im_to_gray(image1);
    grey_image2 = im_to_gray(image2);

    grey_image2 = imrotate(grey_image2,(i-1)*10);
    %0 120   10 56  20  16


    [locs1,desc1] = brief(grey_image1);
    [locs2,desc2] = brief(grey_image2);

    ratio = .8;

    matches = briefMatch(desc1,desc2,ratio);
    locsflipped1 = locs1;
    locsflipped2 = locs2;
    locsflipped1(:,1) = locs1(:,2);
    locsflipped1(:,2) = locs1(:,1);
    locsflipped2(:,1) = locs2(:,2);
    locsflipped2(:,2) = locs2(:,1);
    %plotMatches(grey_image1, grey_image2, matches, locsflipped1, locsflipped2);
    size(matches)
    matchnums(i) = size(matches,1)
end

bar(matchnums);

