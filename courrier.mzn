int: v = 3;
int: it = 4;
array[1..it] of int: items = [1,2,2,3];
int: c = 2;
array[1..c] of int: courriers = [1,3];
array [1..v,1..v] of int: distance = array2d(1..v,1..v,
               [
                    1,2,3,
                    2,3,4,
                    1,3,5
               ]);

array[1..it, 1..c] of var bool: path;

constraint forall(i in 1..it)(count([path[i,x] | x in 1..c],true) = 1); 
constraint forall(x in 1..c)(count([path[i,x] | i in 1..it],true) <= courriers[x]);     

solve satisfy;
