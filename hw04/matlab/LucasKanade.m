function [u,v] = LucasKanade(It,It1,rect)
It = im2double(rgb2gray(It));
It1 = im2double(rgb2gray(It1));
% 330,215
% 420,270
T = It(rect(1):rect(3),rect(2):rect(4));
lastdp = [1;1];
dp = [0;0];
p  = [0;0];
%Warp I with with W(x;p) to compute I(W(x;p))
 [r c] = size(T)
 [FX,FY] = gradient(It1);
 
while (sum(lastdp-dp) > .1)

 H = zeros(2,2);
 newdp = zeros(2,1);
 lastdp = dp;
 
 for r = 1:r
     for c = 1:c
         x = round(rect(1) + r);
         y = round(rect(2) + c);
         W = [1 0 p(1);0 1 p(2)]*[x;y;1];
         
         IW(r,c) = It1(round(W(1)),round(W(2)));
         gI(r,c,:) = [FX(x,y) FY(x,y)] * [1 0;0 1];
        
         i(1:2) = gI(r,c,1:2);
         H = H + i'*i;
         diff(r,c) = T(r,c) - IW(r,c);
         
         newdp = newdp + i'*diff(r,c);
         
     end
 end
 dp = inv(H)*newdp;
 p = p + dp;
 %dp = inv(H)*dp;
 %I(W(x;p)) is the intensity of the image at x,y warped by W
  
 
 %Compute the error image T(x) - I(W(x;p))
 
 %Warp the gradient of I with W(x;p)
 
 %Evaluate the Jacobian dW/dp at (x;p)

end

u = p(1);
v = p(2);

end