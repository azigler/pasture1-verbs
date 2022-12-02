#5:"g*et t*ake"   this none none rxd

set_task_perms(callers() ? caller_perms() | player);
if (this.location == player)
  player:tell("You already have that!");
elseif (this.location != player.location)
  player:tell("I don't see that here.");
else
  this:moveto(player);
  if (this.location == player)
    player:tell(this:take_succeeded_msg() || "Taken.");
    if (msg = this:otake_succeeded_msg())
      player.location:announce(player.name, " ", msg);
    endif
  else
    player:tell(this:take_failed_msg() || "You can't pick that up.");
    if (msg = this:otake_failed_msg())
      player.location:announce(player.name, " ", msg);
    endif
  endif
endif
