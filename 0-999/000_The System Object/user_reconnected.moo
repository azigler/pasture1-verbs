#0:user_reconnected   this none this rxd

if (callers())
  return;
endif
$mcp:(verb)(@args);
if ($object_utils:isa(user = args[1], $guest))
  "from $guest:boot";
  oldloc = user.location;
  move(user, $nothing);
  "..force enterfunc to be called so that the newbie gets a room description.";
  move(user, user.home);
  user:do_reset();
  if ($object_utils:isa(oldloc, $room))
    oldloc:announce("In the distance you hear someone's alarm clock going off.");
    if (oldloc != user.location)
      oldloc:announce(user.name, " wavers and vanishes into insubstantial mist.");
    else
      oldloc:announce(user.name, " undergoes a wrenching personality shift.");
    endif
  endif
  set_task_perms(user);
  `user:confunc() ! ANY';
else
  set_task_perms(user);
  `user:reconfunc() ! ANY';
endif
