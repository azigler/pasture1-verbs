#6:last_huh   this none this rxd

":last_huh(verb,args)  final attempt to parse a command...";
set_task_perms(caller_perms());
{verb, args} = args;
if (verb[1] == "@" && prepstr == "is")
  "... set or show _msg property ...";
  set_task_perms(player);
  $last_huh:(verb)(@args);
  return 1;
elseif (verb in {"give", "hand", "get", "take", "drop", "throw"})
  $last_huh:(verb)(@args);
  return 1;
else
  return 0;
endif
