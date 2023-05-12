function binvec = inrange(vec,limits)
if(numel(limits)==2)
    binvec=(vec>limits(1) & vec<=limits(2));
else
    binvec=[];
end