#93:polar_to_rect   this none this rxd

":polar_to_rect(INT|FLOAT <radius>, INT|FLOAT <angle>) => FLOAT <x>, FLOAT <y>";
"This verb converts from polar (radius, angle) coordinates to rectangulat (x,y) coordinates.";
{r, a} = args[1..2];
r = tofloat(r);
a = tofloat(a);
return {(r = r / (1.0 + (z2 = (z = tan(a / 2.0)) * z))) * (1.0 - z2), r * 2.0 * z};
