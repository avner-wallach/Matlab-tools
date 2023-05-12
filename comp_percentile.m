function centile = comp_percentile(data,value)
    
    data = data(:)';
    value = value(:);
    
    nless = sum(data < value, 2);
    nequal = sum(data == value, 2);
    centile = (nless + 0.5.*nequal) / length(data);
    
end