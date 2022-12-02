#8:"re*move ta*ke g*et"   any (out of/from inside/from) this rxd

if (!(this.location in {player, player.location}))
  player:tell("Sorry, you're too far away.");
elseif (!this.opened)
  player:tell(this.name, " is not open.");
elseif (this.dark)
  player:tell("You can't see into ", this.name, " to remove anything.");
elseif ((dobj = this:match_object(dobjstr)) == $nothing)
  player:tell("What do you want to take from ", this.name, "?");
elseif ($command_utils:object_match_failed(dobj, dobjstr))
elseif (!(dobj in this:contents()))
  player:tell(dobj.name, " isn't in ", this.name, ".");
else
  set_task_perms(callers() ? caller_perms() | player);
  dobj:moveto(player);
  if (dobj.location == player)
    player:tell(this:remove_msg());
    if (msg = this:oremove_msg())
      player.location:announce(player.name, " ", msg);
    endif
  else
    dobj:moveto(this.location);
    if (dobj.location == this.location)
      player:tell(this:remove_msg());
      if (msg = this:oremove_msg())
        player.location:announce(player.name, " ", msg);
      endif
      player:tell("You can't pick up ", dobj.name, ", so it tumbles onto the floor.");
    else
      player:tell(this:remove_fail_msg());
      if (msg = this:oremove_fail_msg())
        player.location:announce(player.name, " ", msg);
      endif
    endif
  endif
endif
