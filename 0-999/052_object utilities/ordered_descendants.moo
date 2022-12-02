#52:ordered_descendants   this none this rxd

r = {what = args[1]};
for k in (children(what))
  if (children(k))
    r = {@r, @this:(verb)(k)};
  else
    r = {@r, k};
  endif
endfor
return r;
