#79:parse_create_args   this none this rxd

"This figures out who is gonna own the stuff @create does.  If one arg, return caller_perms().  If two args, then if caller_perms().wizard, args[2].";
{what, ?who = #-1} = args;
if (!valid(who))
  return caller_perms();
elseif ($perm_utils:controls(caller_perms(), who))
  return who;
else
  return E_INVARG;
endif
