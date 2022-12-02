#68:istype   this none this rxd

":istype(value,types) => whether value is one of the given types";
if ((vtype = typeof(value = args[1])) in (types = args[2]))
  return 1;
elseif (vtype != LIST)
  return 0;
else
  for t in (types)
    if (typeof(t) == LIST && this:islistof(value, t))
      return 1;
    endif
  endfor
endif
return 0;
