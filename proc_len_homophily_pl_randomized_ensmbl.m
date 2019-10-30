clear
%load proc_len.mat dsyn_ar_proc_len dgap_ar_proc_len short med long positions
load proc_len.mat dsyn dgap short med long positions
ar = [short(:,1);med(:,1);long(:,1)];
syn_mat=dsyn(ar,ar); gap_mat = dgap(ar,ar);

% load projection_len.mat syn_mat gap_mat short med long
% load smi_14_10_18.mat senso motor inter btime
% load distances.mat positions


for ii = 1:147
% if ismember(short(ii,1),inter(:,1))
% si(ii,1)=1;
% else
% si(ii,1)=0;
% end

if positions(short(ii,1),1)>-0.2
    head(ii,1)=1;
else
    head(ii,1)=0;
end
end
%ind = find(si==1);
ind2= find(head==1);
%short_btime = btime(short);
early_short=find(short(:,2)<840);
ind3=intersect(ind2,early_short);


proc_len(1).k = ind3;%1:147;
proc_len(2).k = 147+1:147+41;
proc_len(3).k = 147+41+1:147+41+37;

m = sign(gap_mat);
in = sum(sign(gap_mat')); in= in';
out=sum(sign(gap_mat));
m_in_out=in*out;
L=sum(in);
modl_gap_emp=0;
for ii = 1:1
    n=proc_len(ii).k;
    modl_gap_emp = modl_gap_emp + (1/L)*sum(sum(m(n,n)-m_in_out(n,n)/L));
end

for loop=1:1000
    loop
    ar=randperm(225);
    m_rand = m(ar,ar);
    m_in_out_rand = m_in_out(ar,ar);
    modl_gap_rnd=0;
for ii = 1:1
    n=proc_len(ii).k;
    modl_gap_rnd = modl_gap_rnd + (1/L)*sum(sum(m_rand(n,n)-m_in_out_rand(n,n)/L));
end


m_gap_rnd(loop)=modl_gap_rnd;
end
    
m = sign(syn_mat);
in = sum(sign(syn_mat')); in= in';
out = sum(sign(syn_mat));
m_in_out = in*out;
L = sum(in);
modl_syn_emp = 0;
for ii = 1:1
    n=proc_len(ii).k;
    modl_syn_emp = modl_syn_emp + (1/L)*sum(sum(m(n,n)-m_in_out(n,n)/L));
end

for loop=1:1000
    loop
    ar=randperm(225);
    m_rand = m(ar,ar);
    m_in_out_rand = m_in_out(ar,ar);
    modl_syn_rnd=0;
for ii = 1:1
    n=proc_len(ii).k;
    modl_syn_rnd = modl_syn_rnd + (1/L)*sum(sum(m_rand(n,n)-m_in_out_rand(n,n)/L));
end


m_syn_rnd(loop)=modl_syn_rnd;
end
    



