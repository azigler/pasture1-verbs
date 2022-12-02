#13:keep_range   this none this rxd

":keep_range(tree,first,last[,leafkill]) => range";
extract = this:_extract(caller, @args);
if (die = extract[1])
  this:_skill(caller, die[1], {@args, ""}[4]);
endif
return extract[2];
