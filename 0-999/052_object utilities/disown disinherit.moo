#52:"disown disinherit"   this none this rxd

":disown(object) / :disinherit(object)";
" => 1 (for a successful disinheritance)";
" raises E_PERM, E_INVARG, E_ARGS";
cp = caller_perms();
"     no set_task_perms() because we need to be able to";
"     chparent() an object we don't own";
{victim} = args;
parent = parent(victim);
if ($perm_utils:controls(cp, victim))
  raise(E_INVARG, tostr(victim.name, " (", victim, ") is yours.  Use @chparent."));
elseif (!valid(parent))
  raise(E_INVARG, tostr(victim.name, " (", victim, ") is already an orphan."));
elseif (!$perm_utils:controls(cp, parent))
  raise(E_PERM, tostr(parent.name, " (", parent, "), the parent of ", victim.name, " (", victim, "), is not yours."));
elseif (!valid(grandparent = parent(parent)))
  "... still not sure about this... do we care?  --Rog...";
  raise(E_INVARG, tostr(victim.name, " (", victim, ") has no grandparent to take custody."));
else
  chparent(victim, grandparent);
  return 1;
endif
