function P = triangulate(M1,p1,M2,p2)
load('../data/intrinsics.mat');
% 
% R =[1 0 0 0; 0 1 0 0; 0 0 1 0];
 P1 = K1*M1;
% 
% R2 =[1 0 0 162.1; 0 1 0 0; 0 0 1 0];
 P2 = K2*M2;



A = [];
P = [];
for i=1:size(p1,1)
    A = [p1(i,2)*P1(3,:)-P1(2,:); 
        P1(1,:)-p1(i,1)*P1(3,:); 
        p2(i,2)*P2(3,:)-P2(2,:); 
        P2(1,:)-p2(i,1)*P2(3,:)];

    [U S V] = svd(A);
      
    h = V(:,end);    
    rp = P1*h;
    P = [P h/h(4)];
  
end


end