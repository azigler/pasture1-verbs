#57:"@new-password @newpassword"   any is any rd

"@newpassword player is [string]";
"Set's a player's password; omit string to have one randomly generated.";
"Offer to email the password.";
if (!player.wizard)
  return E_PERM;
elseif ($command_utils:player_match_failed(dobj = $string_utils:match_player(dobjstr), dobjstr))
  return;
elseif (!(dobjstr in {@dobj.aliases, tostr(dobj)}))
  player:notify(tostr("Must be a full name or an object number: ", dobj.name, " (", dobj, ")"));
else
  $wiz_utils:do_new_password(dobj, iobjstr);
endif
