#50:abort   none none none rd

if (!this.changes[who = player in this.active])
  player:tell("No changes to throw away.  Editor cleared.");
else
  player:tell("Throwing away session for ", this:working_on(who), ".");
endif
this:reset_session(who);
if (this.exit_on_abort)
  this:done();
endif
