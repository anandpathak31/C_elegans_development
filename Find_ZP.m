function [R1,R2,R3,R4,R5,R6,R7,z_score,p_coeff]=Find_ZP(modules,Adj,N)

L = length(modules);

node_k    = zeros(N,1);
node_mean = zeros(N,1);
node_std  = zeros(N,1);
nodmod    = cell(L);

%-------------------------------------------------------------------------%
for i1 = 1:L % Loop over all the modules

    nodmod{i1} = modules(i1).k; % All the nodes of module i1
    
    for j1 = 1:length(nodmod{i1}) % Loop over each node in module i1
        
        n   = modules(i1).k(j1); % Node j1 of module i1
        
        % Total within-module degree of node
        node_k(n)    = sum(Adj(n,nodmod{i1})) + sum(Adj(nodmod{i1},n));
        
    end
end

for i1 = 1:L % Loop over all the modules
    for j1 = 1:length(nodmod{i1}) % Loop over each node in module i1
        
        n   = modules(i1).k(j1); % Node j1 of module i1
        
        node_mean(n) = mean(node_k(nodmod{i1})); % Mean of within-module degree
        node_std(n)  = std(node_k(nodmod{i1}));  % Std of within-module degree
    end
end

non_conn = node_std==0;
node_std(non_conn) = 1; % to avoid dividing by zero

z_score = (node_k - node_mean)./node_std;
%-------------------------------------------------------------------------%
ppn     = zeros(N,L);
node_k  = zeros(N,1);
p_coeff = zeros(N,1);

for n = 1:N
    
    % Total degree of node n
    node_k(n) = sum(Adj(n,:)) + sum(Adj(:,n));
    
    for j1 = 1:L
        
        mod = modules(j1).k;  % All the members of module j1
        % Total within-module degree of node n in module j1
        ppn(n,j1) = sum(Adj(n,mod)) + sum(Adj(mod,n));
        
    end
    
end

for k1 = 1:N
    p_coeff(k1) = 1- (ppn(k1,:)./node_k(k1,:))*(ppn(k1,:)'./node_k(k1,:));
end

% Make participation coefficient of non-connected nodes 0
%p_coeff(non_conn) = 0;
p_coeff(node_k==0) = 0;
%-------------------------------------------------------------------------%


R1=[];R2=[];R3=[];
R4=[];R5=[];R6=[];R7=[];

for i1=1:N;
    if z_score(i1)<0.7
        if p_coeff(i1)<=0.05
            R1 = [R1 i1];
        elseif p_coeff(i1)<=0.62
            R2 = [R2 i1];
        elseif p_coeff(i1)<=0.8
            R3 = [R3 i1];
        elseif p_coeff(i1)<=1
            R4 = [R4 i1];
        end
    else
        if p_coeff(i1)<=0.3
            R5 = [R5 i1];
        elseif p_coeff(i1)<=0.75
            R6 = [R6 i1];
        else
            R7 = [R7 i1];
        end
    end
end

end