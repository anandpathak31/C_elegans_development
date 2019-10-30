function long_rng_randomized(trial)


 if ischar(trial)
     trial = str2double(trial);
end

load dist_cnstrnd_randomization.mat


dmat=zeros(279);
avg_btime=zeros(279);

syst_time=clock;
 ss=syst_time(6)+syst_time(5)*60+syst_time(4)*3600;
 rand('seed',ss*trial);
RandStream.setDefaultStream(RandStream('mt19937ar','Seed',trial));

for ii = 1:278
    p1=positions(ii,:);
    b1=btime(ii);
    for jj = ii+1:279
     p2=positions(jj,:);
     b2 = btime(jj);
     dd = p1-p2;
     d = sqrt(dd*dd');
     b = (b1+b2)/2;
     dmat(ii,jj)=d; dmat(jj,ii)=d;
     avg_btime(ii,jj)=b; avg_btime(jj,ii)=b;
     
    end
end

m=sign(syn_mat); %for gap junction : m = sign(gap_mat)
[r,c] = find(m>0);
for ii = 1:length(r)

    d_ar(ii,1)=dmat(r(ii),c(ii));
    b_ar(ii,1)=avg_btime(r(ii),c(ii));
    
end
dmax = max(max(dmat));
syn_orig=m;rwr=0;rwr2=0;
length_ar = zeros(279,1);
length_ar(short)=1; length_ar(med)=2;length_ar(long)=3;
ind=find(length_ar==0);
fl = 37/225; fm = 41/225; fs = 147/225;
f_ar = [0,fs,fs+fm];
for ii=1:length(ind)
       pp = sign(rand-f_ar);
       in=find(pp>0); lpp = max(in);
       length_ar(ind(ii)) = lpp;
end

for ii = 1:279
 length_ar_est(ii,1) = dmax*((length_ar(ii)-1)+rand)/3;

end


for ii = 1:2e5
    ii
   
   [r,c] = find(m>0);

   l=length(r);
   rn1 = ceil(rand*l);rn2 = ceil(rand*l);
   r1 = r(rn1); r2 = r(rn2);
   c1 = c(rn1); c2 = c(rn2);
   
   lr1 = length_ar_est(r1);
   lr2 = length_ar_est(r2);
   lc1 = length_ar_est(c1);
   lc2 = length_ar_est(c2);
   
   
   pr1=positions(r1,:);pr2=positions(r2,:);
   pc1=positions(c1,:);pc2=positions(c2,:);
   
   dr1c2 = sqrt((pr1-pc2)*(pr1-pc2)');
   dr2c1 = sqrt((pr2-pc1)*(pr2-pc1)');
   
   if (m(r1,c2)==0)&&(m(r2,c1)==0);
       if (dr1c2<=(lr1+lc2)) && (dr2c1<=(lr2+lc1))
       m(r1,c1)=0; m(r2,c2)=0;
       m(r1,c2)=1; m(r2,c1)=1;
       rwr=rwr+1;
       end
   end

end

[r,c] = find(m>0);
for ii = 1:length(r)

    d_ar2(ii,1)=dmat(r(ii),c(ii));
    b_ar2(ii,1)=avg_btime(r(ii),c(ii));
    
end

% m2=sign(syn);
% [r,c] = find(m2>0);
% 
% for ii = 1:5e5
%     
%    [r,c] = find(m2>0);
% 
%    l=length(r);
%    rn1 = ceil(rand*l);rn2 = ceil(rand*l);
%    r1 = r(rn1); r2 = r(rn2);
%    c1 = c(rn1); c2 = c(rn2);
%    
%    
%    
%    
%    
%    if (m2(r1,c2)==0)&&(m2(r2,c1)==0);
%       % if (dr1c2<=(lr1+lc2)) && (dr2c1<=(lr2+lc1))
%        m2(r1,c1)=0; m2(r2,c2)=0;
%        m2(r1,c2)=1; m2(r2,c1)=1;
%        rwr2=rwr2+1;
%       % end
%    end
% 
% end
% 
% [r,c] = find(m2>0);
% for ii = 1:length(r)
% 
%     d_ar3(ii,1)=dmat(r(ii),c(ii));
%     b_ar3(ii,1)=avg_btime(r(ii),c(ii));
%     
% end

fname = sprintf('Random_net_%d.mat',trial);
        save(fname,'d_ar','b_ar','d_ar2','b_ar2','rwr','m');
        
        



end