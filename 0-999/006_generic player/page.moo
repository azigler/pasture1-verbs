#6:page   any any any rxd

nargs = length(args);
if (nargs < 1)
  player:notify(tostr("Usage: ", verb, " <player> [with <message>]"));
  return;
endif
who = $string_utils:match_player(args[1]);
if ($command_utils:player_match_result(who, args[1])[1])
  return;
elseif (who in this.gaglist)
  player:tell("You have ", who:title(), " @gagged.  If you paged ", $gender_utils:get_pronoun("o", who), ", ", $gender_utils:get_pronoun("s", who), " wouldn't be able to answer you.");
  return;
endif
"for pronoun_sub's benefit...";
dobj = who;
iobj = player;
header = player:page_origin_msg();
text = "";
if (nargs > 1)
  if (args[2] == "with" && nargs > 2)
    msg_start = 3;
  else
    msg_start = 2;
  endif
  msg = $string_utils:from_list(args[msg_start..nargs], " ");
  text = tostr($string_utils:pronoun_sub(($string_utils:index_delimited(header, player.name) ? "%S" | "%N") + " %<pages>, \""), msg, "\"");
endif
result = text ? who:receive_page(header, text) | who:receive_page(header);
if (result == 2)
  "not connected";
  player:tell(typeof(msg = who:page_absent_msg()) == STR ? msg | $string_utils:pronoun_sub("%n is not currently logged in.", who));
else
  player:tell(who:page_echo_msg());
endif
