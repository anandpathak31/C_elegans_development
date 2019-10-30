% PURPOSE:
%     This is to be included in modularity_refinement_fast_weighted.m 
%     It calculates the Q value of the artitions when each node is shifted 
%     to other partition provided it has not been shifted previously.
%
% INPUTS:
%     A          -  The weighted adjacency matrix of the graph
%     nodes(i).k -  nodes in each cluster
%     clust      -  clust and cluster are the module in which the
%                   refinement is to be applied
%     cluster    -  Number of cluster present
% OUTPUTS:
%     Q_local    -  Modularity on changing the ith node to other module

function [Q_local] = refinement_q_calc_weighted(A,color,nodes,size1,clust,cluster,node_present,node_identity)

Q_local=-Inf(1,size1);  % Initial value of change in modularity is -Inf

% Calculate the modularity contribution for the rest of the module
%*****************************************************************
in_degree=sum(A');    % Weighted in-Degree of each node
out_degree=sum(A);    % Weighted out-Degree of each node
L=sum(in_degree);     % Weighted total number of links in the network

Q=0;
for i = 1:clust-1,
    B=A(nodes(i).k,nodes(i).k);
    l_s=sum(sum(B));
    in_d_s=sum(in_degree(nodes(i).k));
    out_d_s=sum(out_degree(nodes(i).k));
    Q=Q+l_s/L-(in_d_s*out_d_s)/L^2;
end
for i = clust+1:cluster-1,
    B=A(nodes(i).k,nodes(i).k);
    l_s=sum(sum(B));
    in_d_s=sum(in_degree(nodes(i).k));
    out_d_s=sum(out_degree(nodes(i).k));
    Q=Q+l_s/L-(in_d_s*out_d_s)/L^2;
end
%*****************************************************************

for i=1:size1,          % For all the nodes present 
    if color(i) == 0,   % Only nodes that are not yet moved
        nodes_local=nodes;
        if node_identity(i) == 1,
            i_index=find(nodes_local(clust).k==node_present(i));
            nodes_local(clust).k(i_index)=[];
            nodes_local(cluster).k(end+1)=node_present(i);
        else
            i_index=find(nodes_local(cluster).k==node_present(i));
            nodes_local(cluster).k(i_index)=[];
            nodes_local(clust).k(end+1)=node_present(i);
        end
        B=A(nodes_local(clust).k,nodes_local(clust).k);
        l_s=sum(sum(B));
        in_d_s=sum(in_degree(nodes_local(clust).k));
        out_d_s=sum(out_degree(nodes_local(clust).k));
        Q_local(i)=Q+l_s/L-(in_d_s*out_d_s)/L^2;
        B=A(nodes_local(cluster).k,nodes_local(cluster).k);
        l_s=sum(sum(B));
        in_d_s=sum(in_degree(nodes_local(cluster).k));
        out_d_s=sum(out_degree(nodes_local(cluster).k));
        Q_local(i)=Q_local(i)+l_s/L-(in_d_s*out_d_s)/L^2;
    end
end