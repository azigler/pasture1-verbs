#50:w*hat   none none none rxd

if (!(this:ok(who = player in this.active) && typeof(this.texts[who]) == LIST))
  player:tell(this:nothing_loaded_msg());
else
  player:tell("You are editing ", this:working_on(who), ".");
  player:tell("Your insertion point is ", this.inserting[who] > length(this.texts[who]) ? "after the last line: next line will be #" | "before line ", this.inserting[who], ".");
  player:tell(this.changes[who] ? this:change_msg() | this:no_change_msg());
  if (this.readable[who])
    player:tell("Your text is globally readable.");
  endif
endif
