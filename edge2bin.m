function [bins] = edge2bin(edges)
%EDGE2BIN convert edges to bin center
bins=mean([edges(1:end-1);edges(2:end)],1);
end

