function map_out=rotate_map(mapin,dx,dy,da,bins,grids)
%interpolate to coordinate system
m1=interp2(bins{1},bins{2}',mapin',grids{1},grids{2}','linear',0);
% m1=mapin';
m2=imtranslate(m1,[dx,dy],'FillValues',0); %shift according to fish motion, pad with zeros
m3=imrotate(m2,rad2deg(da),'bilinear','crop');
m3(m3<0)=0;
% map_out=m3';
%downsample
map_out=imresize(m3,[numel(bins{1}) numel(bins{2})])';
end
