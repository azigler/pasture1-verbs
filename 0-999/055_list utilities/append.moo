#55:append   this none this rxd

"append({a,b,c},{d,e},{},{f,g,h},...) =>  {a,b,c,d,e,f,g,h}";
if (length(args) > 50)
  return {@this:append(@args[1..$ / 2]), @this:append(@args[$ / 2 + 1..$])};
endif
l = {};
for a in (args)
  l = {@l, @a};
endfor
return l;
