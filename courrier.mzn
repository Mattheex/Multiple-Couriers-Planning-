int: v = 9;
int: it = 8;
int: c = 3;
array[1..it] of int: items = [5,6,5,3,8,1,1,4];
array[1..c] of int: courriers = [15,7,5];
array [1..v+1,1..v+1] of int: distance = array2d(1..v+1,1..v+1,
               [
0 ,1 ,3 ,4 ,2 ,5 ,6 ,6 ,4 ,6,
1 ,0 ,4 ,2 ,5 ,6 ,3 ,3 ,1 ,5,
3 ,4 ,0 ,9 ,8 ,9 ,5 ,7 ,1 ,8,
4 ,2 ,9 ,0 ,1 ,2 ,3 ,2 ,2 ,5,
2 ,5 ,8 ,1 ,0 ,4 ,3 ,7 ,5 ,3,
5 ,6 ,9 ,2 ,4 ,0 ,8 ,1 ,8 ,7,
6 ,3 ,5 ,3 ,3 ,8 ,0 ,4 ,8 ,9,
6 ,3 ,7 ,2 ,7 ,1 ,4 ,0 ,4 ,1,
4 ,1 ,1 ,2 ,5 ,8 ,8 ,4 ,0 ,8,
6 ,5 ,8 ,5 ,3 ,7 ,9 ,1 ,8 ,0,
               ]);
               
array[1..it, 1..c] of var bool: path;
array [1..c] of var int: length;

constraint forall(i in 1..it)(count([path[i,x] | x in 1..c],true) = 1); 
constraint forall(x in 1..c)(count([path[i,x] | i in 1..it],true) <= courriers[x]);  

constraint forall(x in 1..c)(length[x] = length_calc(x,0,1));

function var int: length_calc(int: index1, int: pastIndex,int: index) =
  if index > it then 
    if pastIndex = 0 then 0
    else
      distance[items[pastIndex],10]
    endif
  elseif path[index,index1] then
     if pastIndex = 0 then
      length_calc(index1, index, index+1)+distance[10,items[index]]
      else
      length_calc(index1, index, index+1)+distance[items[pastIndex],items[index]]
      endif
  else
    length_calc(index1, pastIndex, index+1)
  endif;

solve minimize sum((x in 1..c))(pow(length[x],2));

