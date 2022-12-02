#50:"pub*lish perish unpub*lish depub*lish"   none none none rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
endif
if (typeof(e = this:set_readable(who, index("publish", verb) == 1)) == ERR)
  player:tell(e);
elseif (e)
  player:tell("Your text is now globally readable.");
else
  player:tell("Your text is read protected.");
endif
