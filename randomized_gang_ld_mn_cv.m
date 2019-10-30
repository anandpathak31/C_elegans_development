clear
load ganglion_lineage.mat;

for ii = 1:length(relat(:,1))
n1=relat(ii,1);
n2=relat(ii,2);
r=relat(ii,3);
ind1=find(gang_nrn==n1);
ind2=find(gang_nrn==n2);
ld_gang_mat(ind1,ind2)=r;
end

for ii = 1:10
for jj = 1:10
m=ld_gang_mat(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1));
s=sum(sum(m));
sq=sum(sum(m.*m));
if (ii==jj)
t=gang_pop(ii)^2-gang_pop(ii);
else
t=gang_pop(ii)*gang_pop(jj);
end
mn=s/t;
mnsq=sq/t;
cv=sqrt(mnsq-mn^2)/mn;
ld_gang_mean(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1))=mn;
ld_gang_cv(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1))=cv;
gang_mn_mat(ii,jj)=mn;gang_mn_mat(jj,ii)=mn;
gang_cv_mat(ii,jj)=cv;gang_cv_mat(jj,ii)=cv;
end
end

for loop = 1:1000
    loop
%rand_relat=relat;

%randomize lineage tree
ind=randperm(279);

%make ganglion-wise lineage distance matrix

rand_ld_gang_mat=ld_gang_mat(ind,ind);



%calculate mean and cv of inter ganglionic and intra ganglionic lineage

for ii = 1:10
for jj = 1:10
m=rand_ld_gang_mat(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1));
s=sum(sum(m));
sq=sum(sum(m.*m));
if (ii==jj)
t=gang_pop(ii)^2-gang_pop(ii);
else
t=gang_pop(ii)*gang_pop(jj);
end
mn=s/t;
mnsq=sq/t;
cv=sqrt(mnsq-mn^2)/mn;
%ld_gang_mean(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1))=mn;
%ld_gang_cv(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1))=cv;
rand_gang_mn_mat(ii,jj,loop)=mn;rand_gang_mn_mat(jj,ii,loop)=mn;
rand_gang_cv_mat(ii,jj,loop)=cv;rand_gang_cv_mat(jj,ii,loop)=cv;
end

end

end

for ii = 1:10
    for jj= 1:10
     ar_mn=rand_gang_mn_mat(ii,jj,:);ar_mn=reshape(ar_mn,loop,1);
     ar_cv=rand_gang_cv_mat(ii,jj,:);ar_cv=reshape(ar_cv,loop,1);
     
     z_mean_mat(ii,jj) = (gang_mn_mat(ii,jj)-mean(ar_mn))/std(ar_mn);
     z_cv_mat(ii,jj) = (gang_cv_mat(ii,jj)-mean(ar_cv))/std(ar_cv);
     
     z_gang_mean(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1))=z_mean_mat(ii,jj);
     z_gang_cv(cum_pop(ii)+1:cum_pop(ii+1),cum_pop(jj)+1:cum_pop(jj+1))=z_cv_mat(ii,jj);
    end
end