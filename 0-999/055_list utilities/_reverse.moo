#55:_reverse   this none this rxd

":_reverse(@list) => reversed list";
if (length(args) > 50)
  return {@this:_reverse(@args[$ / 2 + 1..$]), @this:_reverse(@args[1..$ / 2])};
endif
l = {};
for a in (args)
  l = listinsert(l, a);
endfor
return l;
