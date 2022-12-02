#46:"mail_forward mail_notify"   this none this rxd

who = args[1];
if ($object_utils:has_verb(who, verb))
  return who:(verb)(@listdelete(args, 1));
else
  return {};
endif
