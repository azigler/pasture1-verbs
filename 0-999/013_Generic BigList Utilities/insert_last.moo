#13:insert_last   this none this rxd

":insert_last(tree,insert) => newtree";
"insert a new leaf to be inserted at the righthand end of the tree";
tree = args[1];
insert = args[2];
if (!tree)
  return {caller:_make(0, {insert}), 1, caller:_ord(insert)};
endif
hgt = caller:_get(tree[1]);
rspine = {{tree, plen = length(kids = hgt[2])}};
for i in [1..hgt[1]]
  parent = kids[plen];
  kids = caller:_get(parent[1])[2];
  plen = length(kids);
  rspine = {{parent, plen}, @rspine};
endfor
iord = caller:_ord(insert);
for h in [1..length(rspine)]
  "... tree is the plen'th (rightmost) child of parent...";
  if (rspine[h][2] < this.maxfanout)
    parent = rspine[h][1];
    hgp = caller:_get(parent[1]);
    caller:_put(parent[1], @listset(hgp, {@hgp[2], insert}, 2));
    for p in (rspine[h + 1..length(rspine)])
      rkid = listset(parent, parent[2] + 1, 2);
      parent = p[1];
      hgp = caller:_get(parent[1]);
      caller:_put(parent[1], @listset(hgp, listset(hgp[2], rkid, p[2]), 2));
    endfor
    return listset(tree, tree[2] + 1, 2);
  endif
  insert = {caller:_make(h - 1, {insert}), 1, iord};
endfor
return {caller:_make(length(rspine), {tree, insert}), tree[2] + 1, tree[3]};
