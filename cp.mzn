int: m;
int: n;
array[1..m] of int: l;
array[1..n] of int: s;
int: v = n + 1;
array [1..v,1..v] of int: D;

% Calculate the minimum values for each path
array[1..2] of int: minimum = [min([D[v,i] | i in 1..n]), min([D[i,v] | i in 1..n])];
array[1..m, 1..v, 1..v] of var bool: path;
array [1..m] of var int: length;
var int: total = sum(k in 1..m)(length[k]);

array[1..m, 1..v] of var int: nodes;
constraint forall(k in 1..m, i,j in 1..v)(
  path[k,i,j] -> nodes[k,i] = j
);

% Each path must visit exactly one outgoing node from the depot node
constraint forall(k in 1..m)(sum(i in 1..n)(path[k,v,i]) = 1);
% Each path must visit exactly one incoming node to the depot node
constraint forall(k in 1..m)(sum(i in 1..n)(path[k,i,v]) = 1);
% Each node (excluding the depot node) must be visited exactly once by some path
constraint forall(i in 1..n)(sum([path[k,i,j] | k in 1..m, j in 1..v]) = 1);
% Each node (excluding the depot node) must be visited exactly once as an outgoing node in some path
constraint forall(j in 1..n)(sum([path[k,i,j] | k in 1..m, i in 1..v]) = 1);
% No node can be visited in a path by itself
constraint forall(k in 1..m, i in 1..v)(not path[k,i,i]);
% Each outgoing node in a path must have exactly one incoming connection in the same path
constraint forall(k in 1..m, i,j in 1..v where path[k,i,j])(sum([path[k,j,p] | p in 1..v]) == 1);


% Length of each path must be greater than or equal to the sum of the minimum values
constraint forall(k in 1..m)(length[k] >= sum([minimum[i] | i in 1..2]));
% Length of each path is calculated based on the adjacency matrix and the path variables
constraint forall(k in 1..m)(length[k] = sum(i,j in 1..v)(D[i,j] * path[k,i,j]));
% Length of each path is strictly increasing based on the weights
constraint forall(k1, k2 in 1..m where l[k1] < l[k2])(length[k1] < length[k2]); 


% Sum of weighted nodes in each path must be less than or equal to the corresponding length limit
constraint forall(k in 1..m)(sum([(s[j]*(path[k,i,j])) | i in 1..v,j in 1..n]) <= l[k]);


% Symmetry-breaking constraints to ensure no symmetric solutions are considered
constraint forall(i,j in 1..n where i < j /\ D[i,j] == D[j,i] )(forall(k in 1..m)(not path[k,j,i]));


% Lexicographic order constraints to break symmetry in the path variables
constraint forall(k1, k2 in 1..m where k1 < k2 /\ l[k1] == l[k2])(
  lex_lesseq([path[k1, i, j] | i, j in 1..v where i != j], [path[k2, i, j] | i, j in 1..v where i != j])
 );
% constraint forall(k in 1..m)(
%      lex_lesseq([path[k,i,j] | i,j in 1..v where i != j],[path[k,i,j] | i in reverse(1..v),j in 1..v where i != j]) /\
%      lex_lesseq([path[k,i,j] | i,j in 1..v where i != j],[path[k,j,i] | i in 1..v, j in reverse(1..v) where i != j]) 
% );


solve minimize total;