% PURPOSE:
%     To find the maximum modularity of weighted network (asymmetric) using spectral
%     method with refining proposed; Similat to the one proposed by Newman
%     in Phyiscs 0709.4500 (2007) and PNAS (2006)
%
% INPUTS:
%     Adj  - The Weighted adjacency matrix of the graph
%     Adj(i,j) is 1 if there is an edge from j to i and zero otherwise
%
% OUTPUTS:
%   Q_best - Modularity of the network
%   nodes  - Nodes in each partition when Q is maximum
%

function [Q_best,nodes] = spectral_newman_weighted(Adj)

size1=size(Adj,1);

nodes(1).k=[1:size1];  % Initialization 
cluster=1;             % Number of initial clusters
Q_best=0;              % Initial modularity of the graph
poss_partition(1)=1;   % Whether module is partitionable (1 possible, 0 not possible)

% The Modularity matrix
B=zeros(size1);
in_degree=sum(Adj');       % Weighted in-Degree of the network
out_degree=sum(Adj);       % Weighted out-Degree of the network
L=sum(in_degree);          % Weighted Total number of links
for i=1:size1,
    for j=1:size1,
        B(i,j)=Adj(i,j)-in_degree(i)*out_degree(j)/L;
    end
end

% Partitioning is done till any of the module can be further divided
while max(poss_partition) == 1, 
    
    poss_partition1=find(poss_partition);  % Cluster that can be further subdivided
    for local=1:length(poss_partition1),
        
        clust=poss_partition1(local);      % Index of the cluster
        nodes_present=nodes(clust).k;
        
        % Calculation of generalized modularity matrix
        B1=B(nodes_present,nodes_present);
        sum1=sum(B1');  
        B_g=B1;
        for i=1:length(nodes_present),
            B_g(i,i)=B_g(i,i)-sum1(i);
        end

        % Largest eigenvalue and corresponding eigenvector
        [e_vector,e_value]=eig(B_g+B_g');  
        s=sign(e_vector(:,end)+eps);  % Sign of the eigenvector component gives the module partitioning 
        
        if abs(sum(s)) == length(nodes_present), % All component are of same sign, further partitioning of the module is not possible
            poss_partition(clust) = 0;
            
        else
            nodes(clust).k=nodes_present(find(s==1));
            nodes(cluster+1).k=nodes_present(find(s==-1));
            Q_final=modularity_weighted(Adj,cluster+1,nodes);

            % Now check explicitly whether this partitioning increases modularity
            if Q_final > Q_best,
                cluster=cluster+1;         % Increase the number of cluster
                poss_partition(cluster)=1; % New cluster is assumed to be partitionable
                
                % ************ Further refining algorithm ***************** 
                [Q_refined,nodes_refined] = modularity_refinement_fast_weighted(Adj,clust,cluster,nodes);
                % clust and cluster are the module on which refining
                % algorithm is applied
                Q_best=Q_refined;
                nodes=nodes_refined;
                % *********************************************************
            else
                nodes(cluster+1)=[];       % Partitioning not possible
                nodes(clust).k=nodes_present;
                poss_partition(clust)=0;
            end  % End of Q increase determination loop
        end      % End of if loop ( Whether a certain module is partitionable)
    end          % End of for loop ( on all prtitionable modules)
end              % End of main loop (further partitioning not possible)

