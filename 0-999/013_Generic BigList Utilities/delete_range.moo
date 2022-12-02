#13:delete_range   this none this rxd

":delete_range(tree,first,last[,leafkill]) => newtree";
extract = this:_extract(caller, @args);
if (die = extract[2])
  this:_skill(caller, die[1], {@args, ""}[4]);
endif
return extract[1];
