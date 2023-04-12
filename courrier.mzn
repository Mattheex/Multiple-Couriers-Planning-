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
/* each item is delivered by exactly one courier */
constraint forall(i in 1..it)(count([path[i,x] | x in 1..c],true) = 1);
/* each courier delivers no more items than their capacity. */
constraint forall(x in 1..c)(count([path[i,x] | i in 1..it],true) <= courriers[x]);  
/* calculates the length of the path for each courier and sets the corresponding length variable to that value */
constraint forall(x in 1..c)(length[x] = length_calc(x,0,1));

/* 
This recursive function calculates the length of the path taken by a given courier, given the previous index, current index, and next index.

param: 
  index1 : represents the current index of the courier in the current path studied.
  pastIndex : represents the last index of the courier in the current path studied.
  index :  represents the current position in the array of items.
*/
function var int: length_calc(int: index1, int: pastIndex,int: index) =
  if index > it then /* If we have processed all items, return the distance from last item to depot */
    if pastIndex = 0 then 0 /* If pastIndex is 0, it means no item has been visited yet, so return 0 */
    else
      distance[items[pastIndex],10] /* return distance from last item visited to depot*/
    endif
  elseif path[index,index1] then /* If the item at index can be assigned to the courier at index1 */
     if pastIndex = 0 then /* If no item has been visited yet */
      length_calc(index1, index, index+1)+distance[10,items[index]] /* Add distance from depot to current item */
     else /* If items has been visited */
      length_calc(index1, index, index+1)+distance[items[pastIndex],items[index]] /* Add distance from last visited item to current item */
      endif
  else /* If the item at index cannot be assigned to the courier at index1*/
    length_calc(index1, pastIndex, index+1) /* Skip the current item and move on to the next item */
  endif;

solve minimize sum((x in 1..c))(pow(length[x],2));

