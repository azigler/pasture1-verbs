#58:"@pros*pectus pros*pectus"   any any any rxd

"Usage: @prospectus <player> [from <start>] [to <end>]";
set_task_perms(caller_perms() == $nothing ? player | caller_perms());
dobj = dobjstr ? $string_utils:match_player(dobjstr) | player;
if ($command_utils:player_match_result(dobj, dobjstr)[1])
  return;
endif
dobjwords = $string_utils:words(dobjstr);
if (args[1..length(dobjwords)] == dobjwords)
  args = args[length(dobjwords) + 1..$];
endif
if (!(parse_result = $code_utils:_parse_audit_args(@args)))
  player:notify(tostr("Usage:  ", verb, " player [from <start>] [to <end>]"));
  return;
endif
return $building_utils:do_prospectus(dobj, @parse_result);
