#45:@validate   this (with/using) any rxd

"Syntax:  @validate <recipient> with <password>";
"";
"This command is used to validate an email address set to receive expired messages that did not match the list owner's registered email address. When using the @register command, a password was sent via email to the address specified. This command is to verify that the password was received properly.";
if (caller_perms() != #-1 && caller_perms() != player)
  return player:tell(E_PERM);
elseif (!$perm_utils:controls(player, this))
  return player:tell(E_PERM);
elseif (!this.registered_email)
  return player:tell("No email address has even been set for ", this:mail_name(), ".");
elseif (this.email_validated)
  return player:tell("The email address for ", this:mail_name(), " has already been validated.");
elseif (!iobjstr)
  return player:tell("Usage:  @validate <recipient> with <password>");
elseif (iobjstr != this.validation_password)
  return player:tell("That is not the correct password.");
else
  this.email_validated = 1;
  player:tell("Password validated. Messages that expire after ", this.expire_period == 0 ? "never" | $time_utils:english_time(this.expire_period), " from ", this:mail_name(), " will be emailed to ", this.registered_email, ".");
endif
