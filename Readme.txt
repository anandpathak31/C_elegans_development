README

Codes for
Developmental trajectory of Caenorhabditis elegans nervous system governs its 
structural organization
by A Pathak, N Chatterjee and S Sinha


Files with extension *.m are MATLAB script files or function files

Files with extension *.mat are MATLAB binary files containing data required for 
executing specific programs

Requires MATLAB 2016b Release for execution

Description of the executable codes:

1) proc_len_homophily_pl_randomized_ensmbl.m : 
Calculates modularity (Q) values for empirical network where the network modules are
defined in terms of the process lengths (Short/Medium/Long) of neurons. It also calculates Q for 
randomized ensemble obtained by permuting the process lengths among neurons.

2) proc_len_homophily_ntwrk_randomized_ensmbl.m :
Calculates process length class specific modularity (Q) values for surrogate ensemble
containing randomized networks Random_net_1.mat, Random net_2.mat etc. 
These values then can be compared to class specific modularity values of the empirical network.
The randomized networks are obtained from the empirical synaptic and gap-junction networks 
by constrained swapping of links using dist_cnstrnd_randomization.m (see below).

3) dist_cnstrnd_randomization.m : 
Randomizes the empirical synaptic network (described by ar_bt.mat in terms of its adjacency 
matrix syn_mat) or the gap-junctional network (described by gap_mat in ar_bt.mat).
Randomization is done by permuting links such that degree sequence, spatial location and 
process length of each neuron is unchanged. Only links that are possible given the
length category of the processes is considered. This is a MATLAB function that is
called from inside a loop (running from 1 to N) for generating N randomized networks.

4) btime_homophily.m :
Calculates modularity (Q) values and class specific modularity values for empirical 
synaptic and gap-junction networks, where modules are defined in terms of the 
birth cohort of neurons (early/late). It also calculates Q values and class specific 
Q values for ensembles of randomized networks obtained by using dist_cnstrnd_randomization.m
(see above)

5) randomized_gang_ld_mn_cv.m :
Calculates the mean and coefficient of variation (CV) for inter- and intra-ganglionic 
lineage distances of empirical network, as well as that for the surrogate ensembles of
networks obtained by lineage randomization.

6) stochastic_branching_process.m :
Generates a random ensemble of lineage trees using an asymmetric stochastic branching 
process model. The code allows comparison of the properties of synthetic lineage trees 
with that of the empirical lineage tree.  

7) spectral_newman_weighted.m :
Obtains the modules of any given network given the adjacency matrix.
It uses three MATLAB function files also given here, viz., modularity_weighted.m, 
modularity_refinement_fast_weighted.m and refinement_q_calc_weighted.m

8) Find_ZP.m :
Classifies nodes in a given modular network on the basis of within module degree z-score z 
and participation coefficient p, when given the adjacency matrix, the module membership 
of each node [struct variable type, each element (i) has a list of nodes in module (i)], 
and the size of the network N.

9) log_reg.m :
Performs logistic regression analysis to obtain the relative contributions of different
types of homophily in determining the connection pattern in the synaptic, as well as,
the gap-junctional  network.
Regression coefficients are in the arrays B and B2 (for synapses and gap-junctions, 
respectively).



	



 
