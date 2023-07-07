int: m;
int: n;
array[1..m] of int: l;
array[1..n] of int: s;

int: v = n + 1;
array [1..v,1..v] of int: D;
array[1..2] of int: minimum = [min([D[v,i] | i in 1..n]), min([D[i,v] | i in 1..n])];

array[1..m, 1..v, 1..v] of var bool: path;

array [1..m] of var int: length;
array [1..m] of var int: weight;
constraint forall(k in 1..m)(length[k] >= sum([minimum[i] | i in 1..2]));
constraint forall(k in 1..m)(length[k] = sum(i,j in 1..v)(D[i,j] * path[k,i,j]));
constraint forall(k1, k2 in 1..m where l[k1] < l[k2])(length[k1] < length[k2]);
var int: total = sum(k in 1..m)(length[k]);


constraint forall(k in 1..m)(sum(i in 1..n)(path[k,v,i]) = 1);
constraint forall(k in 1..m)(sum(i in 1..n)(path[k,i,v]) = 1);
constraint forall(i in 1..n)(sum([path[k,i,j] | k in 1..m, j in 1..v]) = 1);
constraint forall(j in 1..n)(sum([path[k,i,j] | k in 1..m, i in 1..v]) = 1);
constraint forall(k in 1..m, i in 1..v)(not path[k,i,i]);
constraint forall(k in 1..m, i,j in 1..v where path[k,i,j])(sum([path[k,j,p] | p in 1..v]) == 1);
%constraint forall(k in 1..m, i in 1..v where exists([path[k,i,j] | j in 1..v])

constraint forall(k in 1..m)(weight[k] = sum([(s[j]*(path[k,i,j])) | i in 1..v,j in 1..n]));
constraint forall(k in 1..m)(weight[k] <= l[k]);

array [1..m, 1..v] of var 0..v : way;
constraint forall(k in 1..m, i in 1..v, j in 1..v)(
  path[k,i,j] -> way[k,i] = j
);


%constraint forall(k in 1..m, i in 1..v where sum([path[k,i,j] | j in 1..v]) == 1)(sum([path[k,j,i] | j in 1..v]) == 1);

constraint forall(i,j in 1..n where i<j /\ D[i,j] == D[j,i] )(forall(k in 1..m)(not path[k,j,i]));

constraint forall(k1, k2 in 1..m where k1 < k2 /\ l[k1] == l[k2])(
    lex_lesseq([path[k1, i, j] | i, j in 1..v where i != j], [path[k2, i, j] | i, j in 1..v where i != j])
);

constraint forall(k in 1..m)(
    lex_lesseq([path[k,i,j] | i,j in 1..v where i != j],[path[k,i,j] | i in reverse(1..v),j in 1..v where i != j]) /\
    lex_lesseq([path[k,i,j] | i,j in 1..v where i != j],[path[k,j,i] | i in 1..v, j in reverse(1..v) where i != j]) 
);

solve minimize total;