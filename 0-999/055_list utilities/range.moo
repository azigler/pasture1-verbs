#55:range   this none this rxd

":range([m,]n) => {m,m+1,...,n}";
{?m = 1, n} = args;
ret = {};
for k in [m..n]
  ret = {@ret, k};
endfor
return ret;
