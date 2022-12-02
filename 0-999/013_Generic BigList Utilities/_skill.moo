#13:_skill   this none this rxd

":_skill(home,node,kill_leaf)";
"home:_kill's node and all descendants, home:(kill_leaf)'s all leaves";
if (caller != this)
  return E_PERM;
endif
{home, node, kill_leaf} = args;
try
  {height, subtrees} = home:_get(node) || {0, {}};
except (E_PROPNF)
  return;
endtry
if (height)
  for kid in (subtrees)
    this:_skill(home, kid[1], kill_leaf);
  endfor
elseif (kill_leaf)
  for kid in (subtrees)
    this:_call(home, kill_leaf, kid);
  endfor
endif
home:_kill(node);
