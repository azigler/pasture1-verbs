#26:"arctan atan"   this none this rxd

"Copied from Trig_Utils (#25800):arctan by Obvious (#54879) Fri Nov 17 06:08:18 1995 PST";
given = args[1];
if (typeof(given) == FLOAT)
  return atan(given);
endif
reciprocal = given * given / 10000 + 10000;
reciprocal = sqrt(reciprocal * 10000);
cosine = 100000000 / reciprocal;
return this:arccos(cosine);
