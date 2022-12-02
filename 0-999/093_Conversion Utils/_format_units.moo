#93:_format_units   this none this rxd

"THIS VERB IS NOT INTENDED FOR USER USAGE.";
":_format_units takes the associative list of units and powers and construct a more user friendly string.";
top = bottom = "";
for pair in (args)
  if (pair[2] > 0)
    top = tostr(top, " ", pair[1], pair[2] > 1 ? pair[2] | "");
  elseif (pair[2] < 0)
    bottom = tostr(bottom, " ", pair[1], pair[2] < -1 ? -pair[2] | "");
  endif
endfor
if (bottom)
  return (top + " /" + bottom)[2..$];
else
  return top[2..$];
endif
