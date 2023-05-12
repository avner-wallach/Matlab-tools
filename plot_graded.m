function [x,Y]=plot_graded(x,y,COL,vec,N,plotting)
    if(nargin>=4)
        [m,I]=sort(vec);
        I(isnan(m))=[];
        y=y(I,:);
        n=round(linspace(1,size(y,1),N+1));
        for k=1:N
            Y(k,:)=nanmean(y(n(k):n(k+1),:),1);
        end
    elseif(nargin==1)
        Y=x;
        x=1:size(Y,2);
        plotting=1;
    else
        Y=y;
        plotting=1;
    end
    if(plotting)
        if(nargin<3)
            COL=colormap(gca,'copper');
        end        
        hold on;
        I=size(Y,1);
        for i=1:I
            H=plot(x,Y(i,:));
            C=COL(round(i/I*size(COL,1)),:);
            set(H,'Color',C,'LineWidth',.25);
        end
        set(gca,'FontSize',16,'Xlim',[min(x) max(x)]);
    end
end
