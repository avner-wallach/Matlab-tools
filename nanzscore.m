function [z,m,s] = nanzscore( z,dim)
%NANZSCORE like zscore ignoring nans
if(nargin==1)
    dim=1;
end
if(dim==2)
    z=z';
end

for i=1:size(z,2)
    m(i)=nanmean(z(:,i));
    s(i)=nanstd(z(:,i));
    z(:,i)=(z(:,i)-m(i))/s(i);
end

if(dim==2)
    z=z';
end

end

