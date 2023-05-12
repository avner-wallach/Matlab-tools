function [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w, dist_h, dist_w,axes_in)
% tight_subplot creates "subplot" axes with adjustable gaps and margins
%
% [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%
%   in:  Nh      number of axes in hight (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins 
%        dist_h  row hight distribution (Nh elements summing up to 1)
%        dist_w  column width distribution (Nw elements summing up to 1)
%        axes_in axes in 
%
%  out:  ha     array of handles of the axes objects
%                   starting from upper left corner, going row-wise as in
%                   subplot
%        pos    positions of the axes objects
%
%  Example: ha = tight_subplot(3,2,[.01 .03],[.1 .01],[.01 .01])
%           for ii = 1:6; axes(ha(ii)); plot(randn(10,ii)); end
%           set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
% Pekka Kumpulainen 21.5.2012   @tut.fi
% Tampere University of Technology / Automation Science and Engineering
if nargin<3; gap = .02; end
if nargin<4 || isempty(marg_h); marg_h = .05; end
if nargin<5; marg_w = .05; end
if(nargin<6 | numel(dist_h)==0); dist_h = 1/Nh*ones(1,Nh); end
if(nargin<7 | numel(dist_w)==0); dist_w = 1/Nw*ones(1,Nw); end
if nargin<8; axes_in=axes('Position',[0 0 1 1]); end

figure(axes_in.Parent);
if numel(gap)==1; 
    gap = [gap gap];
end
if numel(marg_w)==1; 
    marg_w = [marg_w marg_w];
end
if numel(marg_h)==1; 
    marg_h = [marg_h marg_h];
end
p0=axes_in.Position;
x0=p0(1); y0=p0(2); w0=p0(3); h0=p0(4);

AXH = (h0-sum(marg_h)-(Nh-1)*gap(1));
AXW = (w0-sum(marg_w)-(Nw-1)*gap(2));

py = (y0+h0)-marg_h(2); 
% ha = zeros(Nh*Nw,1);
ii = 0;
for ih = 1:Nh
    px = x0+marg_w(1);   
    axh = AXH*dist_h(ih); 
    py = py-axh; 
    for ix = 1:Nw
        ii = ii+1;
        axw = AXW*dist_w(ix);
        ha(ii) = axes('Units','normalized', ...
            'Position',[px py axw axh], ...
            'XTickLabel','', ...
            'YTickLabel','');
        px = px+axw+gap(2);
    end
    py = py-gap(1);
end
if nargout > 1
    pos = get(ha,'Position');
end
ha = ha(:);
axes_in.Visible=0;

