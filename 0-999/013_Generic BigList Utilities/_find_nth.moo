#13:_find_nth   this none this rxd

":_find_nth(home,tree,n) => nth leaf of tree.";
"...Assumes n in [1..tree[2]]";
if (caller != this)
  return E_PERM;
endif
{home, tree, n} = args;
if ((p = home:_get(tree[1]))[1])
  for k in (p[2])
    if (n > k[2])
      n = n - k[2];
    else
      return this:_find_nth(home, k, n);
    endif
  endfor
  return E_RANGE;
else
  return p[2][n];
endif
