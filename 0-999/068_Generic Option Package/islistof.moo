#68:islistof   this none this rxd

":islistof(value,types) => whether value (a list) has each element being one of the given types";
types = args[2];
for v in (value = args[1])
  if (!this:istype(v, types))
    return 0;
  endif
endfor
return 1;
