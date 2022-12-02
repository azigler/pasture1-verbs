#37:_kill_subtrees   this none this rxd

":_kill_subtree(node,count)...wipes out all subtrees";
"...returns count + number of nodes removed...";
if (!($perm_utils:controls(caller_perms(), this) || caller == this))
  return E_PERM;
endif
info = this.(" " + (prefix = args[1]));
count = args[2];
if (ticks_left() < 500 || seconds_left() < 2)
  player:tell("...", count);
  suspend(0);
endif
for i in [1..length(info[2])]
  count = this:_kill_subtrees(n = tostr(prefix, info[1], info[2][i]), count) + 1;
  this:kill_node(n);
endfor
return count;
