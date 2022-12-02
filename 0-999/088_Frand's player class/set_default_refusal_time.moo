#88:set_default_refusal_time   this none this rxd

"'set_default_refusal_time (<seconds>)' - Set the length of time that a refusal lasts if its duration isn't specified.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
this.default_refusal_time = toint(args[1]);
