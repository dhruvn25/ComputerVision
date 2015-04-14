function [M] = LucasKanadeAffine(It,It1)
 if(size(It,3) > 1)
    It = im2double(rgb2gray(It));
 else
     It = double(It);
 end
 if(size(It1,3) > 1) 
    It1 = im2double(rgb2gray(It1));
 else
     It1 = double(It1);
 end
 
  lastdp = [1;1;1;1;1;1];
  dp =     [0;0;0;0;0;0];
  p  =     [0;0;0;0;0;0];
 
  [Xq,Yq] = meshgrid(linspace(1,size(It,2),size(It,2)),linspace(1,size(It,1),size(It,1)));
  %T = interp2(It,Xq,Yq);

  [FX,FY] = gradient(It1);
   W = [1+p(1) p(3) p(5); p(2) 1+p(4) p(6); 0 0 1];
  
  while (sum(abs(lastdp-dp)) > .01)
    %%new p
    lastdp = dp;

    %warp
   
    oldX = [Xq(:) Yq(:) ones(size(Yq(:)))]';
    newX = W*oldX;
    %[Xq2,Yq2] = meshgrid(linspace(newX(1,1),newX(1,end),size(newX,2)),linspace(newX(2,1),newX(2,end),size(newX,2)));
    Xq2 = reshape(newX(1,:),size(Xq));
    Yq2 = reshape(newX(2,:),size(Xq));
    
    IW = interp2(It1,Xq2,Yq2);
    valid_indexes = find(~isnan(IW));
    %gX = interp2(FX,Xq2,Yq2);
    %gY = interp2(FY,Xq2,Yq2);
    %[gX, gY] = gradient(IW);
    gX = interp2(FX,Xq2,Yq2);
    gY = interp2(FY,Xq2,Yq2);
    gI = [];
    gI(:,1) = gX(valid_indexes);
    gI(:,2) = gY(valid_indexes);
    
    %gI2 = reshape(gI,[size(gI,1)*size(gI,2) 2]);
    
    %redo the combination with Jacobian
    J(:,:,1) = [Xq(:) zeros(size(Yq(:))) Yq(:) zeros(size(Yq(:))) ones(size(Yq(:))) zeros(size(Yq(:)))];
    J(:,:,2) = [zeros(size(Yq(:))) Xq(:) zeros(size(Yq(:))) Yq(:) zeros(size(Yq(:))) ones(size(Yq(:)))];
    
    newcombo = repmat(gI(:,2),1,6).*J(valid_indexes,:,2) + repmat(gI(:,1),1,6).*J(valid_indexes,:,1);
    
    H = newcombo'*newcombo;

    diff = It(valid_indexes)-IW(valid_indexes);
    diff2 = reshape(diff,[size(diff,1)*size(diff,2) 1]);

    newdp = newcombo'*diff2;
 
    dp = inv(H)*newdp;
    p = p+ dp;
    %W = W*inv([[1+dp(1) dp(3) dp(5); dp(2) 1+dp(4) dp(6); 0 0 1];]);
    W = [1+p(1) p(3) p(5); p(2) 1+p(4) p(6); 0 0 1];
    
    
  end
  %hold off;
  %pause(.001);
  M = W;
  

end
