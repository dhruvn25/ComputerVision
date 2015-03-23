function [u,v] = LucasKanadeBasis(It,It1,rect,basis)
It = im2double(rgb2gray(It));
It1 = im2double(rgb2gray(It1));
[Xq,Yq] = meshgrid(rect(1):1:rect(3),rect(2):1:rect(4));
T = interp2(It,Xq,Yq);

lastdp = [1;1];
dp = [0;0];
p  = [0;0];
[FX,FY] = gradient(It1);

%It1 = It + sum(w*basis);
k = length(basis);
w = zeros(k,1);
A = zeros(size(basis{1}));
while (sum(abs(lastdp-dp)) > .01)
 
 
 %%new p
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
 
 diff = T - IW;
 
 diff2 = reshape(diff,[size(diff,1)*size(diff,2) 1]);
 
 newdp = gI2'*diff2;
 
 dp = inv(H)*newdp;
 
 %%closed solution for w
 for i=1:k
     A = basis{i};
     size(diff)
     size(A)
     A = A.*-diff;
     w(i) = sum(A(:));
     
 end
 
 
 
 
 p = p + dp;
 
 
 
end

u = p(1);
v = p(2);

end