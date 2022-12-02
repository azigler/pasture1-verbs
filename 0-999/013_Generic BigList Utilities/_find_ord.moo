#13:_find_ord   this none this rxd

":_find_ord(home,tree,n,less_than) ";
" => index of rightmost leaf for which :(less_than)(n,:_ord(leaf)) is false.";
"returns 0 if true for all leaves.";
if (caller != this)
  return E_PERM;
endif
{home, tree, n, less_than} = args;
if ((p = home:_get(tree[1]))[1])
  sz = tree[2];
  for i in [-length(p[2])..-1]
    k = p[2][-i];
    sz = sz - k[2];
    if (!this:_call(home, less_than, n, k[3]))
      return sz + this:_find_ord(home, k, n, less_than);
    endif
  endfor
  return 0;
else
  for i in [1..r = length(p[2])]
    if (this:_call(home, less_than, n, home:_ord(p[2][i])))
      return i - 1;
    endif
  endfor
  return r;
endif
