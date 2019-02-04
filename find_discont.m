function seg_edges = find_discont(idx_vec)
% find discontinuities in index vector and return array of continuous
% segment edges
I=find(diff(idx_vec)>1); 
seg_edges=idx_vec(reshape(sort([1;I(:);I(:)+1;numel(idx_vec)]),2,[])');
end