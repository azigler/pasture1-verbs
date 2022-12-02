#63:reclaim_lost_souls   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
fork (1800)
  this:(verb)();
endfork
for x in (this.lost_souls)
  this.lost_souls = setremove(this.lost_souls, x);
  if (valid(x) && typeof(x.owner.owned_objects) == LIST && !(x in x.owner.owned_objects))
    x.owner.owned_objects = setadd(x.owner.owned_objects, x);
    $quota_utils:summarize_one_user(x.owner);
  endif
  $command_utils:suspend_if_needed(0);
endfor
