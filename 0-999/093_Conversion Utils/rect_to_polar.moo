#93:rect_to_polar   this none this rxd

":rect_to_polar(INT|FLOAT <x>, INT|FLOAT <y>) => FLOAT <radius>, FLOAT <angle>.";
"This verb converts from rectangular (x,y) coordinates to polar (r, theta) coordinates.";
{x, y} = args[1..2];
x = tofloat(x);
y = tofloat(y);
return {sqrt(x * x + x * x), `atan(y, x) ! E_INVARG => 0.0'};
