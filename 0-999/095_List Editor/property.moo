#95:property   this none this rx

"WIZARDLY";
vl = $code_utils:verb_loc();
if (caller != vl || caller_perms() != vl.owner)
  return E_PERM;
endif
set_task_perms(player);
return args[1].(args[2]);
