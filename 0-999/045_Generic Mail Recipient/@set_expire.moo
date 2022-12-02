#45:@set_expire   this (at/to) any rxd

"Syntax:  @set_expire <recipient> to <time>";
"         @set_expire <recipient> to";
"";
"Allows the list owner to set the expiration period of this mail recipient. This is the time messages will remain before they are removed from the list. The <time> given can be in english terms (e.g., 2 months, 45 days, etc.).";
"Non-wizard mailing list owners are limited to a maximum expire period of 180 days. They are also prohibited from setting the list to non-expiring.";
"Wizards may set the expire period to 0 for no expiration.";
"The second form, leaving off the time specification, will tell you what the recipient's expire period is currently set to.";
if (caller_perms() != #-1 && caller_perms() != player)
  return player:tell(E_PERM);
elseif (!this:is_writable_by(player))
  return player:tell(E_PERM);
elseif (!iobjstr)
  return player:tell(this.expire_period ? tostr("Messages will automatically expire from ", this:mail_name(), " after ", $time_utils:english_time(this.expire_period), ".") | tostr("Messages will not expire from ", this:mail_name()));
elseif (typeof(time = $time_utils:parse_english_time_interval(iobjstr)) == ERR)
  return player:tell(time);
elseif (time == 0 && !player.wizard)
  return player:tell("Only wizards may set a mailing list to not expire.");
elseif (time > 180 * 86400 && !player.wizard)
  return player:tell("Only a wizard may set the expiration period on a mailing list to greater than 180 days.");
endif
this.expire_period = time;
player:tell("Messages will ", time != 0 ? tostr("automatically expire from ", this:mail_name(), " after ", $time_utils:english_time(time)) | tostr("not expire from ", this:mail_name()), ".");
