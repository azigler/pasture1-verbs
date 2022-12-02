#13:_extract   this none this rxd

":_extract(home,tree,first,last) => {newtree,extraction}";
if (caller != this)
  return E_PERM;
endif
home = args[1];
if (!(tree = args[2]))
  return {{}, {}};
endif
before = max(0, args[3] - 1);
end = min(tree[2], args[4]);
if (end <= 0 || before >= end)
  return {tree, {}};
endif
height = home:_get(tree[1])[1];
if (end < tree[2])
  r = this:_split(home, height, end, tree);
  if (before)
    l = this:_split(home, height, before, r[1]);
    extract = l[2];
    newtree = this:_merge(home, l[1], r[2]);
  else
    extract = r[1];
    newtree = r[2];
  endif
elseif (before)
  l = this:_split(home, height, before, tree);
  extract = l[2];
  newtree = l[1];
else
  return {{}, tree};
endif
return {this:_scrunch(home, newtree), this:_scrunch(home, extract)};
