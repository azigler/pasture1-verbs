#55:arrayset   this none this rxd

"arrayset(list,value,pos1,...,posn) -- returns list modified such that";
"  list[pos1][pos2][...][posn] == value";
if (length(args) > 3)
  return listset(@listset(args[1..3], this:arrayset(@listset(listdelete(args, 3), args[1][args[3]], 1)), 2));
  "... Rog's entry in the Obfuscated MOO-Code Contest...";
else
  return listset(@args);
endif
