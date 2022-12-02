#95:set_property   this none this rx

"WIZARDLY";
vl = $code_utils:verb_loc();
if (caller != vl || caller_perms() != vl.owner)
  return E_PERM;
endif
{object, pname, value} = args;
set_task_perms(player);
if ($object_utils:has_callable_verb(object, "set_" + pname))
  if (typeof(attempt = object:("set_" + pname)(value)) != ERR)
    return attempt;
  endif
endif
return typeof(e = object.(pname) = value) == ERR ? e | 1;
