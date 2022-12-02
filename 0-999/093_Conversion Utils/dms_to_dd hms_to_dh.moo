#93:"dms_to_dd hms_to_dh"   this none this rxd

":dms_to_dd(INT|FLOAT <deg>, INT|FLOAT <min>, INT|FLOAT <sec>) => FLOAT <deg>";
"This verb converts degrees/minutes/seconds to decimal degrees.";
{d, m, s} = args[1..3];
d = tofloat(d);
m = tofloat(m);
s = tofloat(s);
return d + m / 60.0 + s / 3600.0;
