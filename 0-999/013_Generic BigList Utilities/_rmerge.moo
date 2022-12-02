#13:_rmerge   this none this rxd

":_rmerge(home, tree, insertree) => newtree ";
"(newtree is tree with insertree appended to the right)";
"insertree is assumed to be of height < tree";
if (caller != this)
  return E_PERM;
endif
{home, tree, insert} = args;
if (!tree)
  return insert;
elseif (!insert)
  return tree;
endif
iheight = home:_get(insert[1])[1];
rspine = {};
for i in [iheight + 1..home:_get(tree[1])[1]]
  kids = home:_get(tree[1])[2];
  tlen = length(kids);
  rspine = {{tree, tlen}, @rspine};
  tree = kids[tlen];
endfor
isize = insert[2];
m = this:_smerge(home, iheight, tree, insert);
for h in [1..length(rspine)]
  plen = rspine[h][2];
  parent = rspine[h][1];
  hgp = home:_get(parent[1]);
  if (length(m) - 1 + plen > this.maxfanout)
    home:_put(parent[1], @listset(hgp, listset(hgp[2], m[1], plen), 2));
    parent[2] = parent[2] + isize - m[2][2];
    m = {parent, listset(m[2], home:_make(h + iheight, {m[2]}), 1)};
  else
    home:_put(parent[1], @listset(hgp, {@hgp[2][1..plen - 1], @m}, 2));
    for p in (rspine[h + 1..length(rspine)])
      parent[2] = parent[2] + isize;
      tree = parent;
      parent = p[1];
      hgp = home:_get(parent[1]);
      home:_put(parent[1], @listset(hgp, listset(hgp[2], tree, p[2]), 2));
    endfor
    return listset(parent, parent[2] + isize, 2);
  endif
endfor
return {home:_make(length(rspine) + iheight + 1, m), m[1][2] + m[2][2], m[1][3]};
