% PURPOSE:
%     A modularity refinign algorithm : To Refine the community structure
%     found after spectral method or extremal optimization for weighted 
%     network. Should be applied after each step; it tries to divide the 
%     network into best possible partition. Based on Kernighan-Lin algorithm
%     (Required prog refinement_q_c.m)
%
% INPUTS:
%     A          -  The weighted adjacency matrix of the graph
%     nodes(i).k -  nodes in each cluster
%     clust      -  clust and cluster are the module in which the
%                   refinement is to be applied
%     cluster    -  Number of cluster present
% OUTPUTS:
%     Q          -  Max modularity of the network
%     nodes_best -  Nodes in the the paritions (Max Q)

function [Q,nodes_best] = modularity_refinement_fast_weighted(A,clust,cluster,nodes)

Q=modularity_weighted(A,cluster,nodes);       % Initialization 
node_present=[nodes(clust).k nodes(cluster).k];
size1=length(node_present);          % Total nodes in the two cluster

nodes_best=nodes;    % Best possible partition is initial configuration
delta_Q=eps;         % Initial delta_Q is set positive (required for initial iteration) 

while delta_Q > 0,

    Q_previous=Q;
    color=zeros(size1,1);   % Initializing all nodes as unvisited
    node_present=[nodes(clust).k nodes(cluster).k];
    node_identity=[];
    node_identity(1:length(nodes(clust).k))=1;
    node_identity(end+1:size1)=2;
    
    while min(color)==0,        % All nodes should be visited once in each iteration
    
        [Q_local]=refinement_q_calc_weighted(A,color,nodes,size1,clust,cluster,node_present,node_identity);
        % Give Q value on shifting each node to other module (provided it
        % is not shifted previously)

        % Node having maximum effect on modularity is shifted provided it
        % has not been shifted perviously 
        [max_value,max_index]=max(Q_local);
        color(max_index)=1;  % Color is changed 

        % Shifting is done
        if node_identity(max_index) == 1,
            node_identity(max_index)=2;
            i_index=find(nodes(clust).k==node_present(max_index));
            nodes(clust).k(i_index)=[];
            nodes(cluster).k(end+1)=node_present(max_index);
        else
            node_identity(max_index)=1;
            i_index=find(nodes(cluster).k==node_present(max_index));
            nodes(cluster).k(i_index)=[];
            nodes(clust).k(end+1)=node_present(max_index);
        end

        % If the modularity is increased it is stored 
        if Q_local(max_index) > Q,
            nodes_best=nodes;
            Q=Q_local(max_index);
        end
    end
    
    delta_Q=Q-Q_previous;
end
    
   