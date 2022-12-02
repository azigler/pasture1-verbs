#13:_set_nth   this none this rxd

":_set_nth(home,tree,n,value) => tree[n] = value";
"Assumes n in [1..tree[2]]";
if (caller != this)
  return E_PERM;
endif
{home, tree, n, value} = args;
if ((p = home:_get(tree[1]))[1])
  ik = this:_listfind_nth(p[2], n - 1);
  this:_set_nth(home, p[2][ik[1]], ik[2] + 1, value);
  if (!ik[2])
    p[2][ik[1]][3] = home:_ord(value);
    home:_put(tree[1], @p);
  endif
else
  p[2][n] = value;
  home:_put(tree[1], @p);
endif
