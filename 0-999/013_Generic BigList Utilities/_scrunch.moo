#13:_scrunch   this none this rxd

":_scrunch(home,tree) => newtree";
"decapitates single-child nodes from the top of the tree, returns new root.";
if (caller != this)
  return E_PERM;
endif
if (tree = args[2])
  home = args[1];
  while ((n = home:_get(tree[1]))[1] && length(n[2]) == 1)
    home:_kill(tree[1]);
    tree = n[2][1];
  endwhile
endif
return tree;
