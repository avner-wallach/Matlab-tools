function [hx,hy,Ixy]=compute_info(px1_y,py)
%compute enthropy of distributions of x,y and mutual information of x and y
%given the ditribution of y and the conditional distribution x=1 given y
% x is a bernoulli process! (binary)

px=nansum(px1_y.*py);
%H(x),H(y)
hx=-px*log2(px)-(1-px)*log2(1-px);
hy=-nansum(py.*log2(py));

%I(x;y)
Ixy=nansum(py.*(px1_y.*log2(px1_y/px)+(1-px1_y).*log2((1-px1_y)/(1-px))));
