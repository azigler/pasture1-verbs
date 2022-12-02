#26:cos   this none this rxd

"Copied from Trig_Utils (#25800):cos by Obvious (#54879) Fri Nov 17 06:07:50 1995 PST";
theta = args[1];
if (typeof(theta) == FLOAT)
  return cos(theta);
elseif (typeof(theta) == INT)
  degtheta = 90 - theta;
  mintheta = 0;
elseif (typeof(theta) == LIST)
  degtheta = 89 - theta[1];
  mintheta = 60 - theta[2];
else
  return;
endif
return this:sin({degtheta, mintheta});
