function [Hx,Sx] = entropy(x,K)
% Compute entropy z=H(x) of a discrete variable x.
% Input:
%   x: a integer vectors  
% Output:
%   Hx: entropy Hx=H(x)
%   Sx: selectivity Sx=(log2(N)-Hx)/log2(N)
% Written by Mo Chen (sth4nth@gmail.com).
if(nargin==1)
    K=50;
end
x=x(~isnan(x));
if(numel(unique(x))>K)
    x=discretize(x,K);
end
n = numel(x);
[u,~,x] = unique(x);
k = numel(u);
idx = 1:n;
Mx = sparse(idx,x,1,n,k,n);
Px = nonzeros(mean(Mx,1));
Hx = -dot(Px,log2(Px));
Hx = max(0,Hx);
Sx = (log2(k)-Hx)/log2(k);