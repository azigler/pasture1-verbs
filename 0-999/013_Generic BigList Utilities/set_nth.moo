#13:set_nth   this none this rxd

":set_nth(tree,n,value) => tree";
"modifies tree so that nth leaf == value";
if ((n = args[2]) < 1 || (!(tree = args[1]) || tree[2] < n))
  return E_RANGE;
else
  this:_set_nth(caller, @args);
  return n != 1 ? tree | listset(tree, caller:_ord(args[3]), 3);
endif
