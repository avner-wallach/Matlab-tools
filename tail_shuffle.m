function I=tail_shuffle(K_tail,N)
I=nan(K_tail,N);
ind0=1:K_tail;
for n=1:N    
    ind=randperm(K_tail);
    while(any(ind==ind0))
        ind=randperm(K_tail);
    end
    rowind=n+[0:K_tail-1]*N;
    I(:,n)=rowind(ind);        
end
I=I';
I=I(:);
end