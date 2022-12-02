#10:max_connections   this none this rxd

max = this.max_connections;
if (typeof(max) == LIST)
  if (this:is_lagging())
    max = max[1];
  else
    max = max[2];
  endif
endif
return max;
