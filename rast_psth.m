function [ a1,fmed,fpeak,flat ] = rast_psth(raster,xlim,ylim,sortwind,C,bgc,sz)
    if(nargin<7)
        sz=10;
    end
    if(nargin<6)
        bgc=[1 1 1];
        sz=10;
    end
    if(nargin<5)
        C=[0 0 0];
    end
    if(nargin<4)
        sortwind=[];
    end
    if(nargin<3| numel(ylim)==0)
        ylim=[min(raster(:,2)) max(raster(:,2))];
    end
    if(nargin<2 | numel(xlim)==0)
        xlim=[min(raster(:,1)) max(raster(:,1))];
    end
    
    ind=intersect(find(inrange(raster(:,1),xlim)),find(inrange(raster(:,2),ylim)));
    if(numel(sortwind))
        for i=ylim(1):ylim(2)
            s(i)=sum(raster(ind,2)==i & inrange(raster(ind,1),sortwind));
        end
        [S,idx]=sort(s);
        raster=[raster(ind,1) (raster(ind,2))'];        
    else
        raster=[raster(ind,1)*1e3 raster(ind,2)];
    end        
            
    if(nargout==0)
        figure;
        a1=axes('Position',[0.13 0.4286 0.775 0.5]);
        a2=axes('Position',[0.13 0.11 0.775 0.22]);
    else
        a1=gca;
        P=get(a1,'Position');
        set(a1,'Position',[P(1) P(2)+P(4)*.3 P(3) P(4)*.7]);
        a2=axes('Position',[P(1) P(2) P(3) P(4)*.3]);
    end
    
    axes(a1);
    rastplot(raster,'|',C,sz);        
    set(gca,'Xlim',xlim*1e3,'Ylim',[ylim(1)-1 ylim(end)+1]);   
    set(a1,'Color',bgc,'XColor',1-bgc,'YColor',1-bgc,'FontSize',16,'XTick',[],'YTick',[]);
    

    b=.5;
    edges=[xlim(1)*1e3:b:xlim(2)*1e3];
    bins=edge2bin(edges);
    h=histcounts(raster(:,1),edges)/b/diff(ylim)*1e3;
    axes(a2);
    H=bar(bins,h);
    set(a2,'Color',bgc,'XColor',1-bgc,'YColor',1-bgc,'FontSize',16);
    set(gca,'Xlim',xlim*1e3);
    
    set(H,'FaceColor',C,'EdgeColor',C);
    set(gcf,'Color',bgc);
    
    fmed=median(h);
    [fpeak,I]=max(h(bins>7));
    b=bins(bins>7);
    flat=b(I);
end    


