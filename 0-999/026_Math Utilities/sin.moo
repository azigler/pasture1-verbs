#26:sin   this none this rxd

"Copied from Trig_Utils (#25800):sin by Obvious (#54879) Fri Nov 17 06:07:39 1995 PST";
theta = args[1];
if (typeof(theta) == FLOAT)
  return sin(theta);
elseif (typeof(theta) == INT)
  degtheta = theta % 360;
  mintheta = 0;
elseif (typeof(theta) == LIST)
  degtheta = theta[1] % 360;
  mintheta = theta[2] % 60;
else
  return E_INVARG;
endif
if (mintheta < 0)
  mintheta = mintheta + 60;
  degtheta = degtheta - 1;
endif
while (degtheta < 1)
  degtheta = degtheta + 360;
endwhile
if (mintheta == 0)
  return this.sines[degtheta];
endif
lim1 = this.sines[degtheta];
lim2 = this.sines[degtheta + 1];
delta = lim2 - lim1;
result = (delta * mintheta + 30) / 60 + lim1;
return result;
