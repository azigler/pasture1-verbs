#8:open   this none none rxd

perms = callers() && caller != this ? caller_perms() | player;
if (this.opened)
  player:tell("It's already open.");
  "elseif (this:is_openable_by(player))";
elseif (this:is_openable_by(perms))
  this:set_opened(1);
  player:tell(this:open_msg());
  if (msg = this:oopen_msg())
    player.location:announce(player.name, " ", msg);
  endif
else
  player:tell(this:open_fail_msg());
  if (msg = this:oopen_fail_msg())
    player.location:announce(player.name, " ", msg);
  endif
endif
