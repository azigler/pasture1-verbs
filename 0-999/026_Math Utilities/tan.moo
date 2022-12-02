#26:tan   this none this rxd

"Copied from Trig_Utils (#25800):tan by Obvious (#54879) Fri Nov 17 06:07:53 1995 PST";
{theta} = args;
if (typeof(theta) == FLOAT)
  return tan(theta);
endif
sine = this:sin(theta);
cosine = this:cos(theta);
return (sine * 10000 + (cosine + 1) / 2) / cosine;
