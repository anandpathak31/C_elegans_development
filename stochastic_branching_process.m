clear

for loop= 1:100
    lin_tree_bin=[];
lin_tree_bin(1).node = 1;
p1= 1;%1;%0.99; 
p2 = 0.85;
p3=0.25; p4 = 0.2;
leaf = [];leaf_cnt=0;
for ii = 1:15
    n = lin_tree_bin(ii).node;
    node_next = [];
    if ii<=9
        pp1=p1; pp2=p2;
    else
        pp1=p3; pp2=p4;
    end
    
    for jj = 1:length(n)
        cd = de2bi(n(jj));
        cd = cd(end:-1:1);
        pl=rand; pr=rand;
        if pl<=pp1
            cd1 = [cd 0];
            cd1=cd1(end:-1:1);
            n1 = bi2de(cd1);
            node_next = [node_next n1];
        end
        
        if pr<=pp2
            cd2 = [cd 1];
            cd2=cd2(end:-1:1);
            n2 = bi2de(cd2);
            node_next = [node_next n2];
        end
        
        if pl>pp1 && pr>pp2
            leaf_cnt=leaf_cnt+1;
            leaf(leaf_cnt).node = [cd];
            
        end
            
    end
   lin_tree_bin(ii+1).node = node_next;    
    
end

for ii = 1:length(lin_tree_bin)
    rung_occ_ideal(loop,ii) = length(lin_tree_bin(ii).node);
end

% lineage distance======================================
ll=length(leaf);
lin_dist =zeros(ll*(ll-1)/2,1);cnt=0;

for ii = 1:(length(leaf)-1)
    ii;
    length(leaf);
    n1 = leaf(ii).node;
    for jj = (ii+1):length(leaf)
    n2 = leaf(jj).node;
        cnt=cnt+1;    
        l1=length(n1);l2=length(n2);l=min(l1,l2);
        cm=(n1(1:l)==n2(1:l));
        ind = find(cm==0);
        anc = min(ind)-2;
        ld = (l1-1)+(l2-1)-2*anc-1;
        lin_dist(cnt) = ld;
    
        
    
    end
end

for ii = 1:30
    lineage_dist_prob(loop,ii)=length(find(lin_dist==ii))/length(lin_dist);
    
end    
leaf_sz(loop,1)=leaf_cnt;
    loop

end

mean_rung_occ = mean(rung_occ_ideal);
std_rung_occ = std(rung_occ_ideal);
load lineage_tree_emp.mat rung_occ
figure
errorbar(1:16,mean_rung_occ,std_rung_occ)
hold on
plot(0:15,rung_occ)


load('ganglion_lineage.mat', 'relat')
ld_emp = relat(:,3);
for ii = 1:30
ll = length(find(ld_emp==ii))/length(ld_emp);
ld_hist_emp(ii)=ll;
end

mean_ld_hist_ideal = mean(lineage_dist_prob);
std_ld_hist_ideal = std(lineage_dist_prob);
figure
errorbar(1:30,mean_ld_hist_ideal,std_ld_hist_ideal);
hold on
plot(1:30,ld_hist_emp);