#8:close   this none none rxd

if (!this.opened)
  player:tell("It's already closed.");
else
  this:set_opened(0);
  player:tell(this:close_msg());
  if (msg = this:oclose_msg())
    player.location:announce(player.name, " ", msg);
  endif
endif
