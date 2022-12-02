#4:@audit   any any any rd

"Usage:  @audit [player] [from <start>] [to <end>] [for <matching string>]";
set_task_perms(player);
dobj = $string_utils:match_player(dobjstr);
if (!dobjstr)
  dobj = player;
elseif ($command_utils:player_match_result(dobj, dobjstr)[1])
  return;
endif
dobjwords = $string_utils:words(dobjstr);
if (args[1..length(dobjwords)] == dobjwords)
  args = args[length(dobjwords) + 1..$];
endif
if (!(parse_result = $code_utils:_parse_audit_args(@args)))
  player:notify(tostr("Usage:  ", verb, " [player] [from <start>] [to <end>] [for <match>]"));
  return;
endif
return $building_utils:do_audit(dobj, @parse_result);
