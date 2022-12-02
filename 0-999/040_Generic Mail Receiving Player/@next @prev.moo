#40:"@next @prev"   any any any rd

set_task_perms(player.owner);
if (dobjstr && !(n = toint(dobjstr)))
  player:notify(tostr("Usage:  ", verb, " [<number>] [on <recipient>]"));
elseif (dobjstr)
  this:("@read")(tostr(verb[2..5], n), @listdelete(args, 1));
else
  this:("@read")(verb[2..5], @args);
endif
