#57:"@unnewt @denewt @get-better"   any any any rd

"@denewt <player> [commentary]";
"Remove the player from $Login.newted";
"Sends mail to $newt_log with commentary.";
whostr = args[1];
comment = $string_utils:first_word(argstr)[2];
if (!player.wizard)
  player:notify("Yeah, right.");
elseif ($command_utils:player_match_failed(who = $string_utils:match_player(whostr), whostr))
  return;
else
  "Should parse email address and register user in some clever way.  Ick.";
  if (!(who in $login.newted))
    player:notify(tostr(who.name, " does not appear to be a newt."));
  else
    $login.newted = setremove($login.newted, who);
    if (entry = $list_utils:assoc(who, $login.temporary_newts))
      $login.temporary_newts = setremove($login.temporary_newts, entry);
    endif
    player:notify(tostr(who.name, " (", who, ") got better."));
    $mail_agent:send_message(player, $newt_log, tostr("@denewt ", who.name, " (", who, ")"), comment ? {comment} | {});
  endif
endif
