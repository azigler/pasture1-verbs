#6:disfunc   this none this rxd

if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this) && caller != #0)
  return E_PERM;
endif
this:expunge_rmm();
this:erase_paranoid_data();
this:gc_gaglist();
return;
