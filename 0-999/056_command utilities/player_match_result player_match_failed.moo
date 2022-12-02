#56:"player_match_result player_match_failed"   this none this rxd

":player_match_failed(result,string)";
"  is exactly like :object_match_failed(result,string)";
"  except that its messages are more suitable for player searches.";
":player_match_result(results,strings)";
"  handles a list of results, also presumably from $string_utils:match_player(strings), printing messages to player for *each* of the nonmatching strings.  It returns a list, an overall result (true if some string didn't match --- just like player_match_failed), followed by the list players that matched.";
"";
"An optional 3rd arg gives an identifying string to prefix to each of the nasty messages.";
if (valid(player))
  tell = $perm_utils:controls(caller_perms(), player) ? "notify" | "tell";
  plyr = player;
else
  tell = "notify";
  plyr = $login;
endif
"...";
{match_results, strings, ?cmdid = ""} = args;
pmf = verb == "player_match_failed";
if (typeof(match_results) == OBJ)
  match_results = {match_results};
  strings = {strings};
endif
pset = {};
bombed = 0;
for i in [1..length(match_results)]
  if (valid(result = match_results[i]))
    pset = setadd(pset, match_results[i]);
  elseif (result == $nothing)
    "... player_match_result quietly skips over blank strings";
    if (pmf)
      plyr:(tell)("You must give the name of some player.");
      bombed = 1;
    endif
  elseif (result == $failed_match)
    plyr:(tell)(tostr(cmdid, "\"", strings[i], "\" is not the name of any player."));
    bombed = 1;
  elseif (result == $ambiguous_match)
    lst = $player_db:find_all(strings[i]);
    plyr:(tell)(tostr(cmdid, "\"", strings[i], "\" could refer to ", length(lst) > 20 ? tostr("any of ", length(lst), " players") | $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", lst), "no one", " or "), "."));
    bombed = 1;
  else
    plyr:(tell)(tostr(result, " does not exist."));
    bombed = 1;
  endif
endfor
if (!bombed && !pset)
  "If there were NO valid results, but not any actual 'error', fail anyway.";
  plyr:(tell)("You must give the name of some player.");
  bombed = 1;
endif
return pmf ? bombed | {bombed, @pset};
