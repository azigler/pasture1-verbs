#73:_genprop   this none this rxd

gp = this._genprop;
ngp = "";
for i in [1..length(gp)]
  if (gp[i] != "z")
    ngp = ngp + "bcdefghijklmnopqrstuvwxyz"[strcmp(gp[i], "`")] + gp[i + 1..$];
    return " " + (this._genprop = ngp);
  endif
  ngp = ngp + "a";
endfor
return " " + (this._genprop = ngp + "a");
