clear
 %load proc_len.mat dsyn_ar_proc_len dgap_ar_proc_len
% syn_mat=dsyn_ar_proc_len; gap_mat = dgap_ar_proc_len;

% load projection_len.mat syn_mat gap_mat short med long
% load smi_14_10_18.mat senso motor inter btime
% load distances.mat positions

load ar_bt.mat
% for ii = 1:147
% if ismember(short(ii,1),inter(:,1))
% si(ii,1)=1;
% else
% si(ii,1)=0;
% end
% 
% if positions(short(ii,1),1)>-0.2
%     head(ii,1)=1;
% else
%     head(ii,1)=0;
% end
% end
% ind = find(si==1);
% ind2= find(head==1);
%short_btime = btime(short);
% early_short=find(short(:,2)<840);
% ind3=intersect(ind2,early_short);


btime_grp(1).k = 1:201;
btime_grp(2).k = 201:279;

% btime_grp(1).k = [1:127,148:176];
% btime_grp(2).k = [128:147,177:188];
 
 
% m1 = sign(syn_mat(ar_bt(1:188),ar_bt(1:188)));
m1 = sign(syn_mat(ar_bt_full,ar_bt_full));
in = sum(sign(m1')); in= in';
out=sum(sign(m1));
m_in_out=in*out;
L=sum(in);

for ii = 1:2
    for jj = 1:2
    n1=btime_grp(ii).k;
    n2=btime_grp(jj).k;
    modl_syn_emp(ii,jj) = (1/L)*sum(sum(m1(n1,n2)-m_in_out(n1,n2)/L));
    end
end
Q_syn_emp = modl_syn_emp(1,1)+modl_syn_emp(2,2);

for loop=1:100

    
fname = sprintf('Random_net_%d.mat',loop);

load(fname,'m')
% m = m(ar_bt(1:188),ar_bt(1:188));
m = m(ar_bt_full,ar_bt_full);
in = sum(sign(m')); in= in';
out=sum(sign(m));
m_in_out=in*out;
L=sum(in);




for ii = 1:2
    for jj = 1:2
    n1=btime_grp(ii).k;
    n2=btime_grp(jj).k;
    modl_syn_rnd(ii,jj) = (1/L)*sum(sum(m(n1,n2)-m_in_out(n1,n2)/L));
    end
end


    loop
    

Q_syn_rnd(loop,1) = modl_syn_rnd(1,1)+modl_syn_rnd(2,2);

m_syn_rnd(loop,:,:)=modl_syn_rnd;
end
    
