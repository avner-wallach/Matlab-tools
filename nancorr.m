function [ c ] = nancorr(A,B)
%NANCORR like corr, but excluding nan values
ind=find(~isnan(A) & ~isnan(B));
c=corr(A(ind),B(ind));

end

