function my_plotWithConf_Q(x,Q,colorvec,alpha)

% check inputs
if length(x)~=size(Q,1)
    error('length(x)~=length(Q)');
end

hold('all');

ind=find(isnan(Q(:,2))==0);
area1 = area(x(ind),[Q(ind,1) Q(ind,3)-Q(ind,1)],'LineStyle','none');
set(area1(1),'FaceColor','none');
set(area1(2),'FaceColor',1-(1-colorvec)/2);
set(area1(2),'FaceAlpha',alpha);

% Create plot
plot(x(ind),Q(ind,2),'LineWidth',2,'Color',colorvec);
end
% axis([min(x) max(x) min(y-max(loconf)) max(y+max(hiconf))])