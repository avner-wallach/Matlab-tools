function [COLmap] = colormap_graded(COLin,l0,l1,K)
if(nargin==1)
    l0=.65;
    l1=0.15;
end
if(nargin<4)
    K=64;
end
    Chsl=rgb2hsl(COLin);
    Cmap=[ones(K,1)*Chsl(1:2) linspace(l0,l1,K)'];
    COLmap=hsl2rgb(Cmap);
end

