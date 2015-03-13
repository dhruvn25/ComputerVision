image1 = '../data/pf_scan_scaled.jpg';
image2 = '../data/pf_stand.jpg';

grey_image1 = im_to_gray(image1);
grey_image2 = im_to_gray(image2);



[locs1,desc1] = brief(grey_image1);
[locs2,desc2] = brief(grey_image2);

ratio = .7;

matches = briefMatch(desc1,desc2,ratio);
locsflipped1 = locs1;
locsflipped2 = locs2;
locsflipped1(:,1) = locs1(:,2);
locsflipped1(:,2) = locs1(:,1);
locsflipped2(:,1) = locs2(:,2);
locsflipped2(:,2) = locs2(:,1);
plotMatches(grey_image1, grey_image2, matches, locsflipped1, locsflipped2);
length(matches)

pause
close all;