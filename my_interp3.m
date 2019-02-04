function [ Vq ] = my_interp3(X,Y,Z,V,Zq)
for i=1:numel(X)
    for j=1:numel(Y)
        v=permute(V(i,j,:),[3 2 1]);
        vq=interp1(Z,v,Zq);
        Vq(i,j,:)=permute(vq,[3 2 1]);
    end
end
end

