#6:@registerme   any any any rd

"@registerme as <email-address> -- enter a new email address for player";
"   will change the database entry, assign a new password, and mail the new password to the player at the given email address.";
if (player != this)
  return player:notify(tostr(E_PERM));
endif
who = this;
if ($object_utils:isa(this, $guest))
  who:notify("Sorry, guests should use the '@request' command to request a character.");
  return;
endif
connection = $string_utils:connection_hostname(who);
if (!argstr)
  if ($wiz_utils:get_email_address(who))
    player:tell("You are currently registered as:  ", $wiz_utils:get_email_address(who));
  else
    player:tell("You are not currently registered.");
  endif
  player:tell("Use @registerme as <address> to change this.");
  return;
elseif (prepstr != "as" || !iobjstr || dobjstr)
  player:tell("Usage: @registerme as <address>");
  return;
endif
email = iobjstr;
if (email == $wiz_utils:get_email_address(this))
  who:notify("That is your current address.  Not changed.");
  return;
elseif (reason = $wiz_utils:check_reregistration(this, email, connection))
  if (reason[1] == "-")
    if (!$command_utils:yes_or_no(reason[2..$] + ". Automatic registration not allowed. Ask to be registered at this address anyway?"))
      who:notify("Okay.");
      return;
    endif
  else
    return who:notify(tostr(reason, " Please try again."));
  endif
endif
if ($network.active && !reason)
  if (!$command_utils:yes_or_no(tostr("If you continue, your password will be changed, the new password mailed to `", email, "'. Do you want to continue?")))
    return who:notify("Registration terminated.");
  endif
  password = $wiz_utils:random_password(5);
  old = $wiz_utils:get_email_address(who) || "[ unregistered ]";
  who:notify(tostr("Registering you, and changing your password and mailing new one to ", email, "."));
  result = $network:sendmail(email, tostr("Your ", $network.MOO_Name, " character, ", who.name), "Reply-to: " + $login.registration_address, @$generic_editor:fill_string(tostr("Your ", $network.MOO_name, " character, ", $string_utils:nn(who), " has been registered to this email address (", email, "), and a new password assigned.  The new password is `", password, "'. Please keep your password secure. You can change your password with the @password command."), 75));
  if (result != 0)
    who:notify(tostr("Mail sending did not work: ", reason, ". Reregistration terminated."));
    return;
  endif
  who:notify(tostr("Mail with your new password forwarded. If you do not get it, send regular email to ", $login.registration_address, " with your character name."));
  $mail_agent:send_message($new_player_log, $new_player_log, "reg " + $string_utils:nn(this), {email, tostr("formerly ", old)});
  $registration_db:add(this, email, "Reregistered at " + ctime());
  $wiz_utils:set_email_address(this, email);
  who.password = $login:encrypt_password(password);
  who.last_password_time = time();
else
  who:notify("No automatic reregistration: your request will be forwarded.");
  if (typeof(curreg = $registration_db:find(email)) == LIST)
    additional_info = {"Current registration information for this email address:", @$registration_db:describe_registration(curreg)};
  else
    additional_info = {};
  endif
  $mail_agent:send_message(this, $registration_db.registrar, "Registration request", {"Reregistration request from " + $string_utils:nn(who) + " connected via " + connection + ":", "", "@register " + who.name + " " + email, "@new-password " + who.name + " is ", "", "Reason this request was forwarded:", reason, @additional_info});
endif
