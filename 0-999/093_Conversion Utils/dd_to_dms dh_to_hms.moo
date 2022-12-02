#93:"dd_to_dms dh_to_hms"   this none this rxd

":dd_to_dms(INT|FLOAT <degrees>) => LIST {INT <degrees>, INT <minutes>, FLOAT <seconds>}";
"This verb converts decimal degrees to degrees, minutes, and seconds.";
dd = tofloat(args[1]);
s = ((dd - tofloat(d = toint(dd))) * 60.0 - tofloat(m = toint((dd - tofloat(d)) * 60.0))) * 60.0;
return {d, m, s};
