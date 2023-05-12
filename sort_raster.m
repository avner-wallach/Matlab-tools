function [rast,s]=sort_raster(rast,var)
% sort a raster using variable var

[s,i]=sort(var);
ii=[1:numel(var)];
ii(i)=ii;
ii=[ii nan(1,max(rast(:,2))-numel(ii))];    
rast(:,2)=(ii(rast(:,2)));
rast=sortrows(rast,2);

ind=find(isnan(s));
iind=find(ismember(rast(:,2),ind));
rast(iind,:)=[];
s(ind)=[];
end