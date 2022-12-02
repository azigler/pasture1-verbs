#24:do_new_password   this none this rxd

"do_new_password(who, [password])";
if (!caller_perms().wizard)
  return E_PERM;
endif
{who, ?password = $wiz_utils:random_password(6)} = args;
if (!password)
  password = $wiz_utils:random_password(6);
endif
whostr = $string_utils:nn(who);
player:notify(tostr("About to change password for ", whostr, ". Old encrypted password is \"", who.password, "\""));
who.password = $login:encrypt_password(password);
who.last_password_time = time();
player:notify(tostr(whostr, " new password is `", password, "'."));
if (!$wiz_utils:get_email_address(who))
  player:notify(tostr(whostr, " doesn't have a registered email_address, cannot mail password; tell them some some other way."));
elseif (who.last_connect_time == $maxint && $command_utils:yes_or_no(tostr(who.name, " has never logged in.  Send mail with the password as though this were a new player request?")))
  if ((result = $wiz_utils:send_new_player_mail(tostr("From ", player.name, "@", $network.moo_name, ":"), who.name, $wiz_utils:get_email_address(who), who, password)) == 0)
    player:tell("Mail sent.");
  else
    player:tell("Trouble sending mail: ", result);
  endif
elseif ($command_utils:yes_or_no(tostr("Email new password to ", whostr, "?")))
  player:notify("Sending the password via email.");
  $network:adjust_postmaster_for_password("enter");
  if ((result = $network:sendmail($wiz_utils:get_email_address(who), "Your " + $network.moo_name + " password", "The password for your " + $network.moo_name + " character:", " " + whostr, "has been changed. The new password is:", " " + password, "", "Please note that passwords are case sensitive.")) == 0)
    player:tell("Mail sent.");
  else
    player:tell("Trouble sending mail: ", result);
  endif
  $network:adjust_postmaster_for_password("exit");
else
  player:tell("No mail sent.");
endif
