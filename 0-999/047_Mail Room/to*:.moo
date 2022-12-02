#47:to*:   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (!args)
  player:tell("Your message is currently to ", this:recipient_names(who), ".");
else
  this.recipients[who] = this:parse_recipients({}, args);
  this:set_changed(who, 1);
  player:tell("Your message is now to ", this:recipient_names(who), ".");
endif
