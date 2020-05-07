function [X,Y]=rotate_map(X,Y,x0,y0,a)
TH=atan2((Y-y0,X-x0))-a;
R=((X-x0).^2+(Y-y0).^2).^(.5);
X=R.*cos(TH);
Y=R.*sin(TH);
end
