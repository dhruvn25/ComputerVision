function [u,v] = LucasKanade(It,It1,rect)
It = im2double(rgb2gray(It));
It1 = im2double(rgb2gray(It1));
% 330,215
% 420,270
[Xq,Yq] = meshgrid(rect(1):1:rect(3),rect(2):1:rect(4));
T = interp2(It,Xq,Yq);
%T = It(rect(2):rect(4),rect(1):rect(3));
%imshow(T);
%pause;
lastdp = [1;1];
dp = [0;0];
p  = [0;0];
%Warp I with with W(x;p) to compute I(W(x;p))
 %[r c] = size(T)
 [FX,FY] = gradient(It1);
 
 
 
while (sum(abs(lastdp-dp)) > .01)

 H = zeros(2,2);
 newdp = [0.0;0.0];
 lastdp = dp;
 Xq2 = Xq + p(1);
 Yq2 = Yq + p(2);
 
 IW = interp2(It1,Xq2,Yq2);
 gX = interp2(FX,Xq2,Yq2);
 gY = interp2(FY,Xq2,Yq2);
 gI(:,:,1) = gX;
 gI(:,:,2) = gY;
 gI2 = reshape(gI,[size(gI,1)*size(gI,2) 2]);
 H = gI2'*gI2;
 %size(gI)
 diff = T - IW;
 %imshow(diff);
 diff2 = reshape(diff,[size(diff,1)*size(diff,2) 1]);
 
 newdp = gI2'*diff2;
 %H
 %p
 %figure; imagesc(IW);
 %figure; imagesc(T);
 %pause;
 
 dp = inv(H)*newdp;
 %lastdp-dp
 %pause;
 p = p + dp;
 %dp = inv(H)*dp;
 %I(W(x;p)) is the intensity of the image at x,y warped by W
  
 
 %Compute the error image T(x) - I(W(x;p))
 
 %Warp the gradient of I with W(x;p)
 
 %Evaluate the Jacobian dW/dp at (x;p)
%syms x y;
 %V = [1 0 p(1); 0 1 p(2)]*[x;y;1]
 %[Xq,Yq] = meshgrid(rect(1):rect(3),rect(2):rect(4));
 
%  for r = 1:r
%      for c = 1:c
%          
%          y = rect(2) + r;
%          x = rect(1) + c;
%          %W = [1 0 p(1);0 1 p(2)]*[x;y;1];
%          W = [1 0 p(1);0 1 p(2)]*[x;y;1];
%          IW(r,c) = interp2(It1,W(2),W(1));
%          gX = interp2(FX,y,x);
%          gY = interp2(FY,y,x);
%          gI(r,c,:) = [gX gY] *[1 0;0 1];
%        
%          i(1:2) = gI(r,c,1:2);
%          
%          H = H + i'*i;
%          diff(r,c) = T(r,c) - IW(r,c);
%          newdp = newdp + i'*diff(r,c);
%          
%      end
%  end
 %checkIt = IW - interp2(It1,Xq2,Yq2);
 %pause(.1);
 %dp1 = gI(:,:,1)'*diff;
 %dp2 = gI(:,:,2)'*diff;
 %newdp(1) = sum(dp1(:,1)+dp1(:,2));
 %newdp(2) = sum(dp2(:,1)+dp2(:,2));
end

u = p(1);
v = p(2);

end