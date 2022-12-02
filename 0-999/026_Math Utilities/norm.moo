#26:norm   this none this rxd

":norm(a,b,c,d...) => sqrt(a^2+b^2+c^2+...)";
m = max(max(@args), -min(@args));
logm = length(tostr(m));
if (logm <= 4)
  s = 0;
  for a in (args)
    s = s + a * a;
  endfor
  return toint(sqrt(tofloat(s)));
else
  factor = toint("1" + "0000000"[1..logm - 4]);
  s = 0;
  for a in (args)
    a = a / factor;
    s = s + a * a;
  endfor
  return toint(sqrt(tofloat(s))) * factor;
endif
