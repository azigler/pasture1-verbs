#57:@deprog*rammer   any any any rd

"@deprogrammer victim [for <duration>] [reason]";
"";
"Removes the prog-bit from victim.  If a duration is specified (see help $time_utils:parse_english_time_interval), then the victim is put into the temporary list. He will be automatically removed the first time he asks for a progbit after the duration expires.  Either with or without the duration you can specify a reason, or you will be prompted for one. However, if you don't have a duration, don't start the reason with the word `For'.";
set_task_perms(player);
if (player != this || !player.wizard)
  player:notify("No go.");
  return;
endif
if (!args)
  player:notify(tostr("Usage:  ", verb, " <playername> [for <duration>] [reason]"));
endif
fw = $string_utils:first_word(argstr);
if (fw[2] && (parse = this:parse_templist_duration(fw[2]))[1])
  if (typeof(parse[3]) == ERR || !parse[3])
    player:notify(tostr("Could not parse the duration for restricting programming for ", fw[1], "."));
    return;
  endif
  start = parse[2];
  duration = parse[3];
  reason = parse[4] ? {parse[4]} | {};
else
  start = duration = 0;
  reason = fw[2] ? {fw[2]} | {};
endif
if (!reason)
  reason = {$command_utils:read("reason for resetting programmer flag")};
endif
if (duration)
  reason = {tostr("for ", $time_utils:english_time(duration)), @reason};
endif
if ($command_utils:player_match_failed(victim = $string_utils:match_player(fw[1]), fw[1]))
  "...done...";
elseif (result = $wiz_utils:unset_programmer(victim, reason, @start ? {start, duration} | {}))
  player:notify(tostr(victim.name, " (", victim, ") is no longer a programmer.", duration ? tostr("  This restriction will be lifted in ", $string_utils:from_seconds(duration), ".") | ""));
elseif (result == E_NONE)
  player:notify(tostr(victim.name, " (", victim, ") was already a nonprogrammer..."));
else
  player:notify(tostr(result));
endif
