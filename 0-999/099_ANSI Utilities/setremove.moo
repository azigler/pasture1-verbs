#99:setremove   this none this rxd

":setremove (LIST l, value) => LIST";
"Does the same thing as the built-in setremove(), but if <value> is a";
"string, it will remove any string in <l> that, when it's ANSI codes are";
"stripped out, is equal to <value> with it's ANSI codes stripped out.";
l = args[1];
if (typeof(value = args[2]) != STR || !this:contains_codes(value))
  return setremove(l, value);
endif
nvalue = this:delete(value);
for x in [-length(l)..-1]
  x = -x;
  if (typeof(l[x]) == STR && this:delete(l[x]) == nvalue)
    l = listdelete(l, x);
  endif
endfor
return l;
