#55:"random_item random_element"   this none this rxd

"random_item -- returns a random element of the input list.";
if (length(args) == 1)
  if (typeof(l = args[1]) == LIST)
    if (length(l) > 0)
      return l[random($)];
    else
      return E_RANGE;
    endif
  else
    return E_TYPE;
  endif
else
  return E_ARGS;
endif
