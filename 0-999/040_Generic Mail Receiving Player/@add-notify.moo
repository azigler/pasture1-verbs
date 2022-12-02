#40:@add-notify   any (at/to) any rd

"Ideally, in order for one person to be notified that another person has new mail, both the mail recipient and the notification recipient should agree that this is an OK transfer of information.";
"Usage:  @add-notify me to player";
"    Sends mail to player saying that I want to be added to their mail notification property.";
"Usage:  @add-notify player to me";
"    Makes sure that player wants to be notified, if so, adds them to my .mail_notify property.  (Deletes from temporary record.)";
if (this == dobj)
  target = $string_utils:match_player(iobjstr);
  if ($command_utils:player_match_failed(target, iobjstr))
    return;
  elseif (this in target.mail_notify[1])
    player:tell("You already receive notifications when ", target.name, " receives mail.");
  elseif (this in target.mail_notify[2])
    player:tell("You already asked to be notified when ", target.name, " receives mail.");
  else
    $mail_agent:send_message(player, {target}, "mail notification request", {tostr($string_utils:nn(this), " would like to receive mail notifications when you get mail."), "Please type:", tostr("  @add-notify ", this.name, " to me"), "if you wish to allow this action."});
    player:tell("Notifying ", $string_utils:nn(target), " that you would like to be notified when ", target.ps, " receives mail.");
    target.mail_notify[2] = setadd(target.mail_notify[2], this);
  endif
elseif (this == iobj)
  target = $string_utils:match_player(dobjstr);
  if ($command_utils:player_match_failed(target, dobjstr))
    return;
  elseif (target in this.mail_notify[2])
    this.mail_notify[1] = setadd(this.mail_notify[1], target);
    this.mail_notify[2] = setremove(this.mail_notify[2], target);
    player:tell(target.name, " will be notified when you receive mail.");
  else
    player:tell("It doesn't look like ", target.name, " wants to be notified when you receive mail.");
  endif
else
  player:tell("Usage:  @add-notify me to player");
  player:tell("        @add-notify player to me");
endif
