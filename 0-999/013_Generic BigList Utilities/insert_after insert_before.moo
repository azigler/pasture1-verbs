#13:"insert_after insert_before"   this none this rxd

":insert_after(tree,subtree,n)";
":insert_before(tree,subtree,n)";
"  inserts subtree after (before) the nth leaf of tree,";
"  returning the resulting tree.";
subtree = args[2];
if (tree = args[1])
  if (subtree)
    where = args[3] - (verb == "insert_before");
    if (where <= 0)
      return this:_merge(caller, subtree, tree);
    elseif (where >= tree[2])
      return this:_merge(caller, tree, subtree);
    else
      s = this:_split(caller, caller:_get(tree[1])[1], where, tree);
      return this:_merge(caller, this:_merge(caller, s[1], subtree), s[2]);
    endif
  else
    return tree;
  endif
else
  return subtree;
endif
