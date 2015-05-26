
function [clusterCenters, clusterBelonging,cost] = k_means(data, k, startPoints)

%--------------------------------------
%   YOUR CODE HERE
%--------------------------------------
[xrow,xcolumn] = size(data);

if nargin == 2
    %random start points
    kindex = randperm(xrow);
    kindex = kindex(1:k);
    K = data(kindex,:);
    %K = [-0.0512    0.9895;    1.6254   -1.7188;    0.1246    0.9108;   -0.6242   -0.8930;    2.4271    0.1736];
else
   K = startPoints; 
end
seclastk = 2;
lastk = K;
m = size(K,1);
n = size(data,1);

for i=1:n
    
    for j=1:m
        
        distance(j) = distChiSq(K(j,:)/sum(K(j,:)),data(i,:)/sum(data(i,:)));
        
    end
    [~,I] = min(distance);
    indicies(i) = I(1);
end


while (seclastk ~= lastk)
   %take nearest cluster and reset the center
   for thisk = 1:k
%        sum(data(find(indicies==thisk),:))/length(find(indicies==thisk))
        K(thisk,:) = sum(data(find(indicies==thisk),:))/length(find(indicies==thisk));
   end
   %find new closest centers
   for i=1:n
    
        for j=1:m
            distance(j) = distChiSq(K(j,:)/sum(K(j,:)),data(i,:)/sum(data(i,:)));

        end
        [~,I] = min(distance);
        indicies(i) = I(1);
    end
   
   seclastk = lastk;
   lastk = K;
end
%make a cost function, sum of distance from all cluster centers to all
%points in the cluster
J = 0;
%fprintf('starting on cost\n');
for n = 1:xrow
   for thisk = 1:k
       if (indicies(xrow) == thisk)
       J = J + distChiSq(K(thisk,:),data(xrow,:));
       end
   end
end
cost = J;

%X.^2 

clusterCenters = K;
clusterBelonging = indicies;

end
