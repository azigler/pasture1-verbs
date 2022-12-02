#57:"@toad @toad! @toad!!"   any any any rd

"@toad[!][!] <player> [blacklist|redlist|graylist] [commentary]";
whostr = args[1];
comment = $string_utils:first_word(argstr)[2];
if (verb == "@toad!!")
  listname = "redlist";
elseif (verb == "@toad!")
  listname = "blacklist";
elseif ((ln = {@args, ""}[2]) && index(listname = $login:listname(ln), ln) == 1)
  "...first word of coment is one of the magic words...";
  comment = $string_utils:first_word(comment)[2];
else
  listname = "";
endif
if (!player.wizard || player != this)
  player:notify("Yeah, right... you wish.");
  return;
elseif ($command_utils:player_match_failed(who = $string_utils:match_player(whostr), whostr))
  return;
elseif (whostr != who.name && !(whostr in who.aliases) && whostr != tostr(who))
  player:notify(tostr("Must be a full name or an object number:  ", who.name, "(", who, ")"));
  return;
elseif (who == player)
  player:notify("If you want to toad yourself, you have to do it by hand.");
  return;
endif
dobj = who;
if (msg = player:toad_victim_msg())
  notify(who, msg);
endif
if ($wiz_utils:rename_all_instances(who, "disfunc", "toad_disfunc"))
  player:notify(tostr(who, ":disfunc renamed."));
endif
if ($wiz_utils:rename_all_instances(who, "recycle", "toad_recycle"))
  player:notify(tostr(who, ":recycle renamed."));
endif
"MOO-specific cleanup while still a player object.";
this:toad_cleanup(who);
e = $wiz_utils:unset_player(who, $hacker);
player:notify(e ? tostr(who.name, "(", who, ") is now a toad.") | tostr(e));
if (e && ($object_utils:isa(who.location, $room) && (msg = player:toad_msg())))
  who.location:announce_all_but({who}, msg);
endif
if (listname && !$login:(listname + "ed")(cname = $string_utils:connection_hostname(who.last_connect_place)))
  $login:(listname + "_add")(cname);
  player:notify(tostr("Site ", cname, " ", listname, "ed."));
else
  cname = "";
endif
if (!comment)
  player:notify("So why is this person being toaded?");
  comment = $command_utils:read();
endif
$mail_agent:send_message(player, $toad_log, tostr("@toad ", who.name, " (", who, ")"), {$string_utils:from_list(who.all_connect_places, " "), @cname ? {$string_utils:capitalize(listname + "ed:  ") + cname} | {}, @comment ? {comment} | {}});
player:notify(tostr("Mail sent to ", $mail_agent:name($toad_log), "."));
`$local.waitlist:note_reapee(who, tostr("@toaded by ", player.name)) ! ANY';
