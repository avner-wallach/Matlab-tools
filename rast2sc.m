function [sc] = rast2sc(rasters,win,N)
%RAST2SC extract spike count response from rasters
%   rasters: cell array with rasters for each unit
%   win: window for spike count (in s)
%   N: number of repetitions
%   sc: spike count matrix (columns: units, rows: trials/eods)
if(~iscell(rasters))
    rasters={rasters};
end
bins=[1:N+1];

for i=1:numel(rasters)
    R=rasters{i};
    R=R(inrange(R(:,1),win),2);
    sc(:,i)=histcounts(R,bins);
end

end

