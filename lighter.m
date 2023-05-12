function [ C ] = lighter( C,p)
%LIGHTER change color C luminosity by fraction p 
% 0<=p<=1, p<0 = darker, p>0 =lighter
% C=1-(1-C)*p;
if(isinteger(C))
    C=double(C)/255;
end
Chsl=rgb2hsl(C);
if(numel(size(Chsl))==3)
    CL=Chsl(:,:,3);
else
    CL=Chsl(:,3);
end
if(p<=0)
    CL=CL*(1+p);
else
    CL=1-(1-CL)*p;
end
if(numel(size(Chsl))==3)
    Chsl(:,:,3)=CL;
else
    Chsl(:,3)=CL;
end

C=hsl2rgb(Chsl);
end

