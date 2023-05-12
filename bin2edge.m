function [edges] = bin2edge(bins)
%BIN2EDGE convert bin center to edges
edges=mean([bins(1:end-1);bins(2:end)],1);
de=mean(diff(edges));
edges=[edges(1)-de edges edges(end)+de];
end

