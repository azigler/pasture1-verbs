#5:"d*rop th*row"   this none none rxd

set_task_perms(callers() ? caller_perms() | player);
if (this.location != player)
  player:tell("You don't have that.");
elseif (!player.location:acceptable(this))
  player:tell("You can't drop that here.");
else
  this:moveto(player.location);
  if (this.location == player.location)
    player:tell_lines(this:drop_succeeded_msg() || "Dropped.");
    if (msg = this:odrop_succeeded_msg())
      player.location:announce(player.name, " ", msg);
    endif
  else
    player:tell_lines(this:drop_failed_msg() || "You can't seem to drop that here.");
    if (msg = this:odrop_failed_msg())
      player.location:announce(player.name, " ", msg);
    endif
  endif
endif
