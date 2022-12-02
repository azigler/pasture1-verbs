#48:e*dit   any none none rd

if (this:changed(who = player in this.active))
  player:tell("You are still editing ", this:working_on(who), ".  Please type ABORT or SAVE first.");
elseif (spec = this:parse_invoke(dobjstr, verb))
  this:init_session(who, @spec);
endif
