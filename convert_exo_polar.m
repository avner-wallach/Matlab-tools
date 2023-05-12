function [r,th]=convert_exo_polar(x,y,a,ref,pxl2mm)
%   convert allocentric xoordinates {x,y,a} to egocentric polar coordinates
%   {r,th} relative to ref. ref is circle (wall) or object. convert from
%   pixel to mm using pxl2mm
if(nargin<5)
    pxl2mm=1;
else
    x=x*pxl2mm;
    y=y*pxl2mm;
end
if(isfield(ref,'type')) %object
    objx=ref.x*pxl2mm;
    objy=ref.y*pxl2mm;
    [x,y]=allo2ego(objx,objy,a,x,y); %obj coordinates rel. to LED
    th=atan2(x,y);    %azimuth of object
    r=hypot(x,y); %distance of object from fish's head      
else    %circle
    circle = ref*pxl2mm;
    rx=circle(3)/2; ry=circle(4)/2;    %ellipse radii
    x0=circle(1) + rx; y0=circle(2) + ry; %center point
    phi=atan2((y-y0),(x-x0));    %azimuth in tank
    R1=hypot((x-x0),(y-y0)); %distance of fish from center
    R2=(rx*ry)./sqrt((ry*cos(phi)).^2 + (rx*sin(phi)).^2); %distance of nearest point from cetner
    r=R2-R1;    %distance of fish to nearest wall
    th=phi-a;   %egocentric angle of closest wall
    th(th>pi)=th(th>pi)-2*pi;
    th(th<-pi)=th(th<-pi)+2*pi;    
end
