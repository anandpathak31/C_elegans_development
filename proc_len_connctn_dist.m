clear
load proc_len_connctn_dist.mat
for ii = 1:3
    in1 = [(pop(ii)+1):pop(ii+1)];
    
    for jj = 1:3
        
        in2 = [(pop(jj)+1):pop(jj+1)];
        
        msyn = dsyn_ar_proc_len(in1,in2); 
        msyn = msyn(:);
        msyn = msyn(msyn>0);
        
        mgap = dgap_ar_proc_len(in1,in2);
        mgap = mgap(:);
        mgap = mgap(mgap>0);
        
        mdist = dmat_ar(in1,in2); 
        mdist = mdist(:);
        mdist = mdist(mdist>0);
        
        mn_syn(ii,jj) = mean(msyn);
        mn_gap(ii,jj) = mean(mgap);
        
        ldist = length(mdist);
        lsyn = length(msyn); lgap = length(mgap);
        
        for loop = 1:1000
            
            rnd = randperm(ldist);
            mdist_rnd = mdist(rnd);
            rnd_syn_mn(loop,1) = mean(mdist_rnd(1:lsyn));
            rnd_gap_mn(loop,1) = mean(mdist_rnd(1:lgap));
                   
        end 
        
        mean_rand_syn(ii,jj) = mean(rnd_syn_mn);
        mean_rand_gap(ii,jj) = mean(rnd_gap_mn);
            
        st_rand_syn(ii,jj) = std(rnd_syn_mn);
        st_rand_gap(ii,jj) = std(rnd_gap_mn);
    
    end
end

z_syn = (mn_syn-mean_rand_syn)./st_rand_syn;
z_gap = (mn_gap-mean_rand_gap)./st_rand_gap;