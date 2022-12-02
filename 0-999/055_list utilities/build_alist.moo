#55:build_alist   this none this rxd

"Syntax:  build_alist(list, N) =>";
"{list[1..N], list[N+1..N*2], list[N*2+1..N*3], ..., list[N*(N-1)+1..N*N]}";
"";
"Creates an associated list from a flat list at every Nth interval. If the list doesn't have a multiple of N elements, E_RANGE is returned.";
"Example:  build_alist({a,b,c,d,e,f,g,h,i},3)=>{{a,b,c},{d,e,f},{g,h,i}}";
{olist, interval} = args;
if ((tot = length(olist)) % interval)
  return E_RANGE;
endif
nlist = {};
d = 1;
while (d <= tot)
  nlist = {@nlist, olist[1..interval]};
  olist[1..interval] = {};
  d = d + interval;
endwhile
return nlist;
