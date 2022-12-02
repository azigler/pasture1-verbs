#55:amerge   this none this rxd

"Copied from Uther's_Ghost (#93141):amerge Tue May 27 20:28:18 1997 PDT";
"amerge(list[,tindex[,dindex]]) returns an associated list such that all the tuples in the original list with the same tindex-th element are merged. Useful for merging alists ( amerge({@alist1, @alist2, ...}) ) and for ensuring that each tuple has a unique index. Tindex defaults to 1. Dindex defaults to 1 and refers to the position in the tuple where the tindex-th element will land in the new tuple.";
{alist, ?tidx = 1, ?didx = 1} = args;
if (alist)
  alist = this:sort_alist(alist, tidx);
  i = 1;
  res = {{cur = alist[1][tidx]}};
  for tuple in (alist)
    if (tuple[tidx] == cur)
      res[i] = {@res[i], @listdelete(tuple, tidx)};
    else
      if (didx != 1)
        res[i] = this:swap_elements(res[i], 1, min(didx, length(res[i])));
      endif
      i = i + 1;
      res = {@res, {cur = tuple[tidx], @listdelete(tuple, tidx)}};
    endif
  endfor
  return res;
endif
return alist;
