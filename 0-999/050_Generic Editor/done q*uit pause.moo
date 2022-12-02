#50:"done q*uit pause"   none none none rxd

if (!(caller in {this, player}))
  return E_PERM;
elseif (!(who = player in this.active))
  player:tell("You are not actually in ", this.name, ".");
  return;
elseif (!valid(origin = this.original[who]))
  player:tell("I don't know where you came here from.");
else
  player:moveto(origin);
  if (player.location == this)
    player:tell("Hmmm... the place you came from doesn't want you back.");
  else
    if (msg = this:return_msg())
      player.location:announce($string_utils:pronoun_sub(msg));
    endif
    return;
  endif
endif
player:tell("You'll have to use 'home' or a teleporter.");
