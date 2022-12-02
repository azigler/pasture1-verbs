#43:sun   this none this rxd

{?time = time()} = args;
r = 10000;
h = r * r + r / 2;
t = (time + 120) % 86400 / 240;
s = 5 * ((time - 14957676) % 31556952) / 438291;
phi = s + t + this.corr;
cs = $trig_utils:cos(s);
spss = ($trig_utils:sin(phi) * $trig_utils:sin(s) + h) / r - r;
cpcs = ($trig_utils:cos(phi) * cs + h) / r - r;
return (this.stsd * cs - this.ctcd * cpcs - this.ct * spss + h) / r - r;
