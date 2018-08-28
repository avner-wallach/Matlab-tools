function bins=edge2bin(edges)
x=edges(:);
bins=mean([x(1:end-1)';x(2:end)']);
end