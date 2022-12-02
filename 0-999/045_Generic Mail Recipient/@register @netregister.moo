#45:"@register @netregister"   this (at/to) any rxd

"Syntax:   @register <recipient> to <email-address>";
"alias     @netregister <recipient> to <email-address>";
"          @register <recipient> to";
"";
"The list owner may use this command to set a registered email address for the mail recipient. When set, mail messages that expire off of the mail recipient will be mailed to that address.";
"If you leave the email address off of the command, it will return the current registration and expiration information for that recipient if you own it.";
"The owner may register a mail recipient to any email address. However, if the address does not match his registered email address, then a password will be generated and sent to the address specified when this command is used. Then, the owner may retrieve that password and verify the address with the command:";
"";
"  @validate <recipient> with <password>";
"";
"See *B:MailingListReform #98087 for full details.";
if (caller_perms() != #-1 && caller_perms() != player)
  return player:tell(E_PERM);
elseif (!$perm_utils:controls(player, this))
  return player:tell(E_PERM);
elseif (!iobjstr)
  if (this.registered_email)
    player:tell(this:mail_name(), " is registered to ", this.registered_email, ". Messages will be sent there when they expire after ", this.expire_period == 0 ? "never" | $time_utils:english_time(this.expire_period), ".");
  else
    player:tell(this:mail_name(), " is not registered to any address. Messages will be deleted when they expire after ", this.expire_period == 0 ? "never" | $time_utils:english_time(this.expire_period), ".");
    player:tell("Usage:  @register <recipient> to <email-address>");
  endif
  return;
elseif (iobjstr == $wiz_utils:get_email_address(player))
  this.registered_email = $wiz_utils:get_email_address(player);
  this.email_validated = 1;
  player:tell("Messages expired from ", this:mail_name(), " after ", this.expire_period == 0 ? "never" | $time_utils:english_time(this.expire_period), " will be emailed to ", this.registered_email, " (which is your registered email address).");
elseif (reason = $network:invalid_email_address(iobjstr))
  return player:tell(reason, ".");
elseif (!$network.active)
  return player:tell("The network is not up at the moment. Please try again later or contact a wizard for help.");
else
  password = $wiz_utils:random_password(5);
  result = $network:sendmail(iobjstr, tostr($network.MOO_Name, " mailing list verification"), @$generic_editor:fill_string(tostr("The mailing list ", this:mail_name(), " on ", $network.MOO_Name, " has had this address designated as the recipient of expired mail messages. If this is not correct, then you need do nothing but ignore this message. If this is correct, you must log into the MOO and type:  `@validate ", this:mail_name(), " with ", password, "' to start receiving expired mail messages."), 75));
  if (result != 0)
    return player:tell("Mail sending did not work: ", result, ". Address not set.");
  endif
  this.registered_email = iobjstr;
  this.email_validated = 0;
  this.validation_password = password;
  player:tell("Registration complete. Password sent to the address you specified. When you receive the email, log back in to validate it with the command:  @validate <recipient> with <password>. If you do not receive the password email, try again or notify a wizard if this is a recurring problem.");
endif
