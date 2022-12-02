#99:setadd   this none this rxd

":setadd (LIST l, value) => LIST";
"Does the same thing as the built-in setadd(), but if <value> is a string,";
"it won't be added to <l> if <value> with it's ANSI codes stripped out equals";
"any of <l>'s elements with their ANSI codes stripped out.";
l = args[1];
if (typeof(value = args[2]) == STR && this:contains_codes(value))
  nvalue = this:delete(value);
  for x in (l)
    if (typeof(x) == STR && this:delete(x) == nvalue)
      return l;
    endif
  endfor
endif
return setadd(l, value);
