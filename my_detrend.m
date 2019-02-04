function TR=my_detrend(tr,Nz)
N=size(tr,2);
if(nargin==1)
    Nz=N;
end
if(numel(Nz)==1)
    Nz=[1 Nz];
end
% Nz=round(N/2);
a=tr(:,Nz(1));
z=tr(:,Nz(2));
slope=(z-a)/(diff(Nz)-1);
x=[1:N]-1;
TR=tr-repmat(a,1,N);
TR=TR-slope*x;
end