function z = mutInfo(x, y, K)
% Compute mutual information I(x,y) of two discrete variables x and y.
% Input:
%   x, y: two integer vector of the same length 
%   K: number of bins
% Output:
%   z: mutual information z=I(x,y)
% Written by Mo Chen (sth4nth@gmail.com).
assert(numel(x) == numel(y));
if(nargin<3)
    K=6;
end
x=x(~isnan(x));
if(numel(unique(x))>K)
    x=discretize(x,K);
end
y=y(~isnan(y));
if(numel(unique(y))>K)
    y=discretize(y,K);
end

n = numel(x);
x = reshape(x,1,n);
y = reshape(y,1,n);

l = min(min(x),min(y));
x = x-l+1;
y = y-l+1;
k = max(max(x),max(y));

idx = 1:n;
Mx = sparse(idx,x,1,n,k,n);
My = sparse(idx,y,1,n,k,n);
Pxy = nonzeros(Mx'*My/n); %joint distribution of x and y
Hxy = -dot(Pxy,log2(Pxy));

Px = nonzeros(mean(Mx,1));
Py = nonzeros(mean(My,1));

% entropy of Py and Px
Hx = -dot(Px,log2(Px));
Hy = -dot(Py,log2(Py));
% mutual information
z = Hx+Hy-Hxy;
z = max(0,z);