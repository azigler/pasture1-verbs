#13:_listfind_nth   this none this rxd

"_listfind_nth(nodelist,key) => {i,k} where i is the smallest i such that the sum of the first i elements of intlist is > key, and k==key - sum(first i-1 elements).";
"1 <= i <= length(intlist)+1";
{lst, key} = args;
for i in [1..length(lst)]
  key = key - lst[i][2];
  if (0 > key)
    return {i, key + lst[i][2]};
  endif
endfor
return {length(lst) + 1, key};
