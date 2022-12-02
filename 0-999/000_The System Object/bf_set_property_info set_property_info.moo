#0:"bf_set_property_info set_property_info"   this none this rxd

who = caller_perms();
retval = 0;
try
  {what, propname, info} = args;
except (E_ARGS)
  retval = E_ARGS;
endtry
try
  {owner, perms, ?newname = 0} = info;
except (E_ARGS)
  retval = E_ARGS;
except (E_TYPE)
  retval = E_TYPE;
endtry
if (retval != 0)
elseif (newname in {"object_size", "size_quota", "queued_task_limit"} && !who.wizard)
  retval = E_PERM;
else
  set_task_perms(who);
  retval = `set_property_info(@args) ! ANY';
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
