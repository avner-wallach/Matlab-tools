function [d] = normrows(X)
%normrows norm of each row in matrix
d=(sum(X.^2,2)).^.5;
end

