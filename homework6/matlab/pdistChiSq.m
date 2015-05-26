function D = pdistChiSq( X, Y )
%From Columbia Univ. 
for j=1:size(Y,1)
    D(j) = distChiSq(X,Y(j,:));
end