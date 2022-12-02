#3:"e east w west s south n north ne northeast nw northwest se southeast sw southwest u up d down"   none none none rxd

set_task_perms(caller_perms() == #-1 ? player | caller_perms());
exit = this:match_exit(verb);
if (valid(exit))
  exit:invoke();
elseif (exit == $failed_match)
  player:tell("You can't go that way.");
else
  player:tell("I don't know which direction `", verb, "' you mean.");
endif
