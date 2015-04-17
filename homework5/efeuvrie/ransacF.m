function [F] = ransacF(pts1,pts2,M)
iter = 100;
thresh = 1e-12;
bestF = [];
bestError = 0;
bestInliers = 0;
thisError = 0;
for i=1:iter
    idx = randperm(size(pts1,1));
    p1 = [pts1(idx,:) ones(size(pts1,1),1)];
    p2 = [pts2(idx, :) ones(size(pts1,1),1)];
    %Fc = sevenpoint(p1,p2,M);
    
    Fc = eightpoint(p1(1:8,:),p2(1:8,:),M);
    if(iscell(Fc))
        for j=1:size(Fc,2)
            thisError = 0;
            thisInliers = 0;
            inliers = zeros(size(pts1,1));
            for n=1:size(pts1,1)
                 error = [pts2(n,:)';1]'*Fc{j}*[pts1(n,:)';1];
                 error = error^2 / sum(pts2(n,1:2).^2 + pts1(n,1:2).^2);
                if (abs(error) < thresh)
                    thisInliers = thisInliers + 1;
                    thisError = thisError + abs(error);
                    inliers(n) = 1;
                end
            end

            if (thisInliers > bestInliers)
                bestError = thisError / thisInliers;
                bestInliers = thisInliers
                inliersSet = inliers; 
                bestF = Fc{j};
            end

        end
    else
        thisError = 0;
            thisInliers = 0;
            inliers = zeros(size(pts1,1));
            for n=1:size(pts1,1)
                 error = [pts2(n,:)';1]'*Fc*[pts1(n,:)';1];
                 error = error^2 / sum(pts2(n,1:2).^2 + pts1(n,1:2).^2);
                if (abs(error) < thresh)
                    thisInliers = thisInliers + 1;
                    thisError = thisError + abs(error);
                    inliers(n) = 1;
                end
            end

            if (thisInliers > bestInliers)
                bestError = thisError / thisInliers;
                bestInliers = thisInliers
                inliersSet = inliers; 
                bestF = Fc;
            end
    end
    fprintf('Iteration %d \n',i);
end

%F = eightpoint(pts1(find(inliersSet),:),pts2(find(inliersSet),:),M);
%F = sevenpoint(pts1(find(inliersSet),:),pts2(find(inliersSet),:),M);
F = refineF(bestF,pts1(find(inliersSet),:),pts2(find(inliersSet),:));
end