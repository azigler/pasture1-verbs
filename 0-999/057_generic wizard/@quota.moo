#57:@quota   any is any rd

"@quota <player> is [public] <number> [<reason>]";
"  changes a player's quota.  sends mail to the wizards.";
if (player != this)
  return player:notify("Permission denied.");
endif
set_task_perms(player);
dobj = $string_utils:match_player(dobjstr);
if ($command_utils:player_match_result(dobj, dobjstr)[1])
  return;
elseif (!valid(dobj))
  player:notify("Set whose quota?");
  return;
endif
if (iobjstr[1..min(7, $)] == "public ")
  iobjstr[1..7] = "";
  if ($object_utils:has_property($local, "public_quota_log"))
    recipients = {$quota_log, $local.public_quota_log};
  else
    player:tell("No public quota log.");
    return E_INVARG;
  endif
else
  recipients = {$quota_log};
endif
old = $quota_utils:get_quota(dobj);
qstr = iobjstr[1..(n = index(iobjstr + " ", " ")) - 1];
new = $code_utils:toint(qstr[1] == "+" ? qstr[2..$] | qstr);
reason = iobjstr[n + 1..$] || "(none)";
if (typeof(new) != INT)
  player:notify(tostr("Set ", dobj.name, "'s quota to what?"));
  return;
elseif (qstr[1] == "+")
  new = old + new;
endif
result = $quota_utils:set_quota(dobj, new);
if (typeof(result) == ERR)
  player:notify(tostr(result));
else
  player:notify(tostr(dobj.name, "'s quota set to ", new, "."));
endif
$mail_agent:send_message(player, recipients, tostr("@quota ", dobj.name, " (", dobj, ") ", new, " (from ", old, ")"), tostr("Reason for quota ", new - old < 0 ? "decrease: " | "increase: ", reason, index("?.!", reason[$]) ? "" | "."));
