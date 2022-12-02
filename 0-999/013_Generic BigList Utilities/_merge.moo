#13:_merge   this none this rxd

"_merge(home,ltree,rtree) => newtree";
"assumes ltree and rtree to be nonempty.";
if (caller != this)
  return E_PERM;
endif
{home, lnode, rnode} = args;
lh = home:_get(lnode[1])[1];
rh = home:_get(rnode[1])[1];
if (lh > rh)
  return this:_rmerge(home, lnode, rnode);
endif
for h in [lh + 1..rh]
  lnode[1] = home:_make(h, {lnode});
endfor
m = this:_smerge(home, rh, lnode, rnode);
return length(m) <= 1 ? m[1] | {home:_make(rh + 1, m), m[1][2] + m[2][2], m[1][3]};
