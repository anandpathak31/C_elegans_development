clear
% load proc_len.mat dsyn_ar_proc_len dgap_ar_proc_len
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


proc_len(1).k = 1:147;
proc_len(2).k = 147+1:147+41;
proc_len(3).k = 147+41+1:147+41+37;
 

for loop=1:100

    
fname = sprintf('Random_net_%d.mat',loop);

load(fname,'m')
m = m(ar_bt,ar_bt);
in = sum(sign(m')); in= in';
out=sum(sign(m));
m_in_out=in*out;
L=sum(in);




for ii = 1:3
    for jj = 1:3
    n1=proc_len(ii).k;
    n2=proc_len(jj).k;
    modl_syn_rnd(ii,jj) = (1/L)*sum(sum(m(n1,n2)-m_in_out(n1,n2)/L));
    end
end


    loop
    



m_syn_rnd(loop,:,:)=modl_syn_rnd;
end
    
