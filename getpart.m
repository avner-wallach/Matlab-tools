function ind=getpart(inds,k,K)
% get kth part out of K partitions of indices inds
first=round((k-1)/K*numel(inds))+1;
last=round(k/K*numel(inds));
ind=inds(first:last);
end