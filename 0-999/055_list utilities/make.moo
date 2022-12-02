#55:make   this none this rxd

":make(n[,elt]) => a list of n elements, each of which == elt. elt defaults to 0.";
{n, ?elt = 0} = args;
if (n < 0)
  return E_INVARG;
endif
ret = {};
build = {elt};
while (1)
  if (n % 2)
    ret = {@ret, @build};
  endif
  if (n = n / 2)
    build = {@build, @build};
  else
    return ret;
  endif
endwhile
