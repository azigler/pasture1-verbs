#6:@password   any any any rd

if (typeof(player.password) != STR)
  if (length(args) != 1)
    return player:notify(tostr("Usage:  ", verb, " <new-password>"));
  else
    new_password = args[1];
  endif
elseif (length(args) != 2)
  player:notify(tostr("Usage:  ", verb, " <old-password> <new-password>"));
  return;
elseif (!argon2_verify(player.password, args[1]))
  player:notify("That's not your old password.");
  return;
elseif (is_clear_property(player, "password"))
  player:notify("Your password has a `clear' property.  Please refer to a wizard for assistance in changing it.");
  return;
elseif (player in $wiz_utils.change_password_restricted)
  player:notify("You are not permitted to change your own password.");
  return;
else
  new_password = args[2];
endif
if (r = $password_verifier:reject_password(new_password, player))
  player:notify(r);
  return;
endif
player.password = $login:encrypt_password(new_password);
player.last_password_time = time();
player:notify("New password set.");
