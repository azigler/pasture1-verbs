#88:clear_refusals   this none this rxd

"'clear_refusals ()' - Erase all of this player's refusals.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
this.refused_origins = {};
this.refused_actions = {};
this.refused_until = {};
this.refused_extra = {};
