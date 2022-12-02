#50:emote   any any any rxd

if (caller != player && caller_perms() != player)
  return E_PERM;
endif
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
else
  this:append_line(who, argstr);
endif
