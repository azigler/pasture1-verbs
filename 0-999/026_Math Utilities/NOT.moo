#26:NOT   this none this rxd

return -(1 + args[1]);
"";
"... here's what it used to be ...";
bl1 = this:BLFromInt(args[1]);
blOut = {};
for i in [1..32]
  blOut = {@blOut, !bl1[i]};
endfor
return this:IntFromBL(blOut);
