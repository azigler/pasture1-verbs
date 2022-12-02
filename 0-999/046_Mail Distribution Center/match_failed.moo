#46:match_failed   this none this rxd

{match_result, string, ?cmd_id = ""} = args;
cmd_id = cmd_id || "";
if (match_result == $nothing)
  player:tell(cmd_id, "You must specify a valid mail recipient.");
elseif (match_result == $failed_match)
  player:tell(cmd_id, "There is no mail recipient called \"", string, "\".");
elseif (match_result == $ambiguous_match)
  if ((nostar = index(string, "*") != 1) && (lst = $player_db:find_all(string)))
    player:tell(cmd_id, "\"", string, "\" could refer to ", length(lst) > 20 ? tostr("any of ", length(lst), " players") | $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", lst), "no one", " or "), ".");
  else
    player:tell(cmd_id, "I don't know which \"", nostar ? "*" | "", string, "\" you mean.");
  endif
elseif (!valid(match_result))
  player:tell(cmd_id, match_result, " does not exist.");
else
  return 0;
endif
return 1;
