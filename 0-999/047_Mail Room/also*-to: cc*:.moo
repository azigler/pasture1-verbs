#47:"also*-to: cc*:"   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
else
  this.recipients[who] = this:parse_recipients(this.recipients[who], args);
  this:set_changed(who, 1);
  player:tell("Your message is now to ", this:recipient_names(who), ".");
endif
