#8:"p*ut in*sert d*rop"   any (in/inside/into) this rxd

if (this.location != player && this.location != player.location)
  player:tell("You can't get at ", this.name, ".");
elseif (dobj == $nothing)
  player:tell("What do you want to put ", prepstr, " ", this.name, "?");
elseif ($command_utils:object_match_failed(dobj, dobjstr))
elseif (dobj.location != player && dobj.location != player.location)
  player:tell("You don't have ", dobj.name, ".");
elseif (!this.opened)
  player:tell(this.name, " is closed.");
else
  set_task_perms(callers() ? caller_perms() | player);
  dobj:moveto(this);
  if (dobj.location == this)
    player:tell(this:put_msg());
    if (msg = this:oput_msg())
      player.location:announce(player.name, " ", msg);
    endif
  else
    player:tell(this:put_fail_msg());
    if (msg = this:oput_fail_msg())
      player.location:announce(player.name, " ", msg);
    endif
  endif
endif
