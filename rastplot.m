function [ H] = rastplot(raster,symbol,COL,fontsize)
if(nargin==1)
    H=plot(raster(:,1),raster(:,2),'.');
else
    if(nargin==3)
        fontsize=12;
    end
%     H=text(raster(:,1),raster(:,2),symbol);
% set(H,'FontSize',fontsize,'Color',COL);
    if(numel(COL)==3)
        H=scatter(raster(:,1),raster(:,2),fontsize,COL,'filled');    
    else
        H=scatter(raster(:,1),raster(:,2),fontsize,raster(:,2),'filled');    
    end
%     set(H,'MarkerFaceColor',COL,'MarkerEdgeColor',COL);
%     set(gca,'Xlim',[min(raster(:,1)) max(raster(:,1))],'Ylim',[min(raster(:,2)) max(raster(:,2))])
end
end

