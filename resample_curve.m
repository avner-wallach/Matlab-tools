function [Xn,Yn] = resample_curve(X,Y,N)
%RESAMPLE_CURVE resample curve given by collection of points [X,Y] to N
%total new points

%compute segment and total length
for i=2:numel(X)
    d(i)=norm(diff([X(i-1:i) Y(i-1:i)]));
end
D=cumsum(d); %commulative length
T=linspace(0,D(end),N);
Xn(1)=X(1);
Yn(1)=Y(1);
for j=2:N
    n=find(T(j)<=D,1); %find next node
    Xn(j)=X(n-1)+(X(n)-X(n-1))/d(n)*(T(j)-D(n-1));
    Yn(j)=Y(n-1)+(Y(n)-Y(n-1))/d(n)*(T(j)-D(n-1));
end
Xn=Xn';
Yn=Yn';
end
