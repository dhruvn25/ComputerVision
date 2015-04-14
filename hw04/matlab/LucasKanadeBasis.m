function [u,v] = LucasKanadeBasis(It,It1,rect,basis)
  It = im2double(rgb2gray(It));
  It1 = im2double(rgb2gray(It1));

  lastdp = [1;1];
  dp = [0;0];
  p  = [0;0];

  %pre-compute

  [Xq,Yq] = meshgrid(linspace(rect(1),rect(3),39),linspace(rect(2),rect(4),60));
  T = interp2(It,Xq,Yq);
  [FX,FY] = gradient(T);
  %create Jacobian
  W = [1 0 p(1); 0 1 p(2)];
  J = [1 0; 0 1]; 
  k = length(basis);
  A = zeros(size(basis{1}));
  %compute SDq(x) across T
  SDQ(:,:,1) = FX;
  SDQ(:,:,2) = FY;
  allA = zeros(size(SDQ));
  %lambda = []
  for i=1:k
    A = basis{i};
    lambda = A.*FX;
    l(1) = sum(lambda(:));
    lambda = A.*FY;
    l(2) = sum(lambda(:));
    lA(:,:,1) = l(1)*A;
    lA(:,:,2) = l(2)*A;
    allA = allA + lA;
  end
  SDQ = SDQ - allA;
  SDQx = SDQ(:,:,1);
  SDQy = SDQ(:,:,2);

  H1 = SDQ(:,:,1).*SDQ(:,:,1);
  H2 = SDQ(:,:,1).*SDQ(:,:,2);
  H3 = SDQ(:,:,2).*SDQ(:,:,1);
  H4 = SDQ(:,:,2).*SDQ(:,:,2);

  H = [sum(H1(:)) sum(H2(:)); sum(H3(:)) sum(H4(:))];



  %It1 = It + sum(w*basis);
  %figure;imshow(T);
  %imshow(It1);hold on;
  while (sum(abs(lastdp-dp)) > .01)
	
	
    %%new p
    newdp = [0.0;0.0];
    lastdp = dp;
    Xq2 = Xq + p(1);
    Yq2 = Yq + p(2);
    
    IW = interp2(It1,Xq2,Yq2);

    diff = T-IW;
    
    SDDiffx = SDQ(:,:,1).*diff;
    SDDiffy = SDQ(:,:,2).*diff;
    sumSDDiff = [sum(SDDiffx(:)) sum(SDDiffy(:))];
    
    dp = inv(H)*sumSDDiff';
    
    p = p + dp;
    %plot(rect(1) + p(1), rect(2) + p(2),'bO');
   %plot(rect(3) + p(1), rect(4) + p(2),'bO');
    
  end
  %hold off;
  %pause(.001);
  u = p(1);
  v = p(2);

end
