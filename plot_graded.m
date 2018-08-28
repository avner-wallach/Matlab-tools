function plot_graded(x,y,vec,N)
    if(nargin==4)
        [m,I]=sort(vec);
        y=y(I,:);
        n=linspace(1,size(y,1),N+1);
        for k=1:N
            Y(k,:)=nanmean(y(n(k):n(k+1),:),1);
        end
    else
        Y=y;
    end
    F=figure;
    A=axes;
    hold on;
    COL=colormap('winter');
    I=size(Y,1);
    for i=1:I
        H=plot(x,Y(i,:));
        C=COL(round(i/I*64),:);
        set(H,'Color',C,'LineWidth',5);
    end
    set(A,'FontSize',16,'Xlim',[min(x) max(x)]);
end
