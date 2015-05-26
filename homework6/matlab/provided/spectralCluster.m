%% Given an Affinity matrix compute spectral clustering
%
% Input:
%   A - Affinity (similarity) matrix between each superpixels should be square
%   k - Number of clusters, 2 if you want to extract fg and bg
%   T - type of normalization, defaults to 'Shi' can be 'Jordan'
% Output:
%   C - cluster ids for each superpixel
%
% Modification History:
%   Yiying Li: CV Spring 2015

function C = spectralCluster(A, k, T)
if (nargin < 3)
    T = 'Shi';
end

W=A;

% compute degrees
ds = sum(W, 2);
D = sparse(1:size(W, 1), 1:size(W, 2), ds);
L = D - W;

if strcmp(T, 'Shi')
    % laplacian normalization Shi and Malik 
    ds(ds == 0) = eps;
    D = spdiags(1./ds, 0, size(D, 1), size(D, 2));
    L = D*L;
elseif strcmp(T, 'Jordan')
    % laplacian normalization Jordan and Weiss
    ds(ds == 0) = eps;
    D = spdiags(1./(ds.^0.5), 0, size(D, 1), size(D, 2));
    L = D * L * D;
end

% compute eigenvectors
[U, ~] = eigs(L, k, eps);

if strcmp(T, 'Jordan')
    U = bsxfun(@rdivide, U, sqrt(sum(U.^2, 2)));
end
%U
% project onto clusters
C = kmeans(U, k, 'EmptyAction', 'singleton');
end