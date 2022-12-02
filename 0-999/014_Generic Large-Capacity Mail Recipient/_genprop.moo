#14:_genprop   this none this rxd

gp = this._genprop;
ngp = "";
for i in [1..length(gp)]
  if (gp[i] != "z")
    ngp = ngp + "bcdefghijklmnopqrstuvwxyz"[index("abcdefghijklmnopqrstuvwxy", gp[i])] + gp[i + 1..length(gp)];
    return " " + (this._genprop = ngp);
  endif
  ngp = ngp + "a";
endfor
return " " + (this._genprop = ngp + "a");
