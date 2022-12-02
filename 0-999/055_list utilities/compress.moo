#55:compress   this none this rxd

"compress(list) => list with consecutive repeated elements removed, e.g.,";
"compress({a,b,b,c,b,b,b,d,d,e}) => {a,b,c,b,d,e}";
if (l = args[1])
  out = {last = l[1]};
  for x in (listdelete(l, 1))
    if (x != last)
      out = listappend(out, x);
      last = x;
    endif
  endfor
  return out;
else
  return l;
endif
