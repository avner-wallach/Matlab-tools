function COLmap=invert_map(COLin)
    Chsl=rgb2hsl(COLin);
    Cmap=[Chsl(:,1:2) 1-Chsl(:,3)];
    COLmap=hsl2rgb(Cmap);
end