load log_regress.mat
X = []; Ysyn= []; Ygap = []; p = 0;
syn=syn_mat; gap=gap_mat;
for ii = 1:224
    for jj = ii+1:225
        n1 = sample(ii,1); n2 = sample(jj,1);
    l = lineage_dist_mat(n1,n2);
    
    if ismember(n1,left) 
        ind = find(left==n1);
        if n2==right(ind)
           prd=1; 
        else
            prd=0;
        end
    elseif ismember(n1,right) 
        ind = find(right==n1);
        if n2==left(ind)
           prd=1; 
        else
            prd=0;
        end
    else
        prd = 0;
    end
    
    if btime(n1)<840 && btime(n2)<840
        bt = 1;
    elseif btime(n1)>840 && btime(n2)>840
        bt = 1;
    else
        bt = 0;
    end
    
    if sample(ii,2)==sample(jj,2)
        proc = 1;
    else
        proc = 0;
    end
    dd = positions(n1,:)-positions(n2,:);
    dd = sqrt(dd*dd');
    
    ar = [l,prd,bt,proc];
    X = [X;ar;ar];
    if (syn(n1,n2)>0)%&&(dd>0.4)
        Ysyn = [Ysyn;1];
    else
        Ysyn = [Ysyn;2];
    end
    
    if (syn(n2,n1)>0)% && (dd>0.4)
        Ysyn = [Ysyn;1];
    else
        Ysyn = [Ysyn;2];
    end
    
    if gap(n1,n2)>0 %&& (dd>0.4)
        Ygap = [Ygap;1;1];
    else
        Ygap = [Ygap;2;2];
    end
    
        
    end
    
    
end

[B,dev,stats] = mnrfit(X,Ysyn);
[B2,dev2,stats2] = mnrfit(X,Ygap);