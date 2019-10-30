% PURPOSE:
%     To find the modularity of a weighted network 
%
% INPUTS:
%     A  - The weighted adjacency matrix of the graph
%     A(i,j) is 1 if there is an edge from j to i and zero otherwise
%     cluster - total number of cluster
%     nodes(i).k - nodes in each cluster
% OUTPUTS:
%     Q - Modularity of the network

function [Q] = modularity_weighted(A,cluster,nodes)

in_degree=sum(A');    % Weighted In Degree of each node
out_degree=sum(A);    % Weighted Out Degree of each node
L=sum(in_degree);     % Weighted Number of links in the network L=sum(in_degree)=sum(out_degree)

Q=0;
for i = 1:cluster,
    B=A(nodes(i).k,nodes(i).k);
    l_s=sum(sum(B));
    in_d_s=sum(in_degree(nodes(i).k));
    out_d_s=sum(out_degree(nodes(i).k));
    Q=Q+l_s/L-(in_d_s*out_d_s)/L^2;
end

%size1=size(A,1);
% The community matrix
%C=zeros(size1);
%for i=1:cluster,
%    C([nodes(i).k],[nodes(i).k])=1;
%end

%Q=0;
%for i = 1:size1,
%    for j = 1:size1,
%        Q=Q+(A(i,j)-in_degree(i)*out_degree(j)/L)*C(i,j)/L;
%    end
%end
