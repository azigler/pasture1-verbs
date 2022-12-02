#3:here_huh   this none this rxd

":here_huh(verb,args)  -- room-specific :huh processing.  This should return 1 if it finds something interesting to do and 0 otherwise; see $command_utils:do_huh.";
"For the generic room, we check for the case of the caller specifying an exit for which a corresponding verb was never defined.";
set_task_perms(caller_perms());
if (args[2] || $failed_match == (exit = this:match_exit(verb = args[1])))
  "... okay, it's not an exit.  we give up...";
  return 0;
elseif (valid(exit))
  exit:invoke();
else
  "... ambiguous exit ...";
  player:tell("I don't know which direction `", verb, "' you mean.");
endif
return 1;
