#52:isoneof   this none this rxd

":isoneof(x,y) = x isa z, for some z in list y";
{what, targ} = args;
while (valid(what))
  if (what in targ)
    return 1;
  endif
  what = parent(what);
endwhile
return 0;
