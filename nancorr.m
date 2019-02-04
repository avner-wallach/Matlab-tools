function [ c,p ] = nancorr(A,B,N)
%NANCORR like corr, but excluding nan values
ind=find(~isnan(A) & ~isnan(B));
A=A(ind);
B=B(ind);
[c,p]=corr(A,B);
% compute p by random permutations
% if(nargin>2)
%     for n=1:N;
%     %     cp(n)=corr(A(ind),B(ind(randperm(numel(ind)))));
%         idx(:,n)=randperm(numel(ind));
%     end
%     cp=corr(A,B(idx));
%     pp=sum(abs(cp)>=abs(c))/N;
% else
%     pp=nan;
% end
end

