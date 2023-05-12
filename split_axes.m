function [Hout,Pout] = split_axes(Hin,Rows,Cols,dx,dy,dl,dr,db,dt)
%SPLIT_AXES split axes Hin into a grid of sub-axes with spacing dx and dy 
% Rows - number of rows
% Cols - number of columns
% dx - separation between cols
% dy - separation between rows
% dl - left margin
% dr - right margin
% db - bottom margin
% dt - top margin
if(nargin<6)
    dl=0;
    dr=0;
    db=0;
    dt=0;
end
axes(Hin);
P=Hin.Position;
x0=P(1)+dl; y0=P(2)+db; w0=P(3)-dl-dr; h0=P(4)-db-dt;
w=(w0-dx*(Cols-1))/Cols;
h=(h0-dy*(Rows-1))/Rows;
y=y0+(dy+h)*(Rows-1); k=1;
for i=1:Rows
    x=x0;
    for j=1:Cols
        p=[x y w h];
        Hout(k)=axes('Position',p);
        Pout(k,:)=p;
        x=x+w+dx;
        k=k+1;
    end
    y=y-h-dy;
end
Hin.Visible='off';
end

