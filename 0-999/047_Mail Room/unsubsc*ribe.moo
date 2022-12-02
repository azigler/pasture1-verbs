#47:unsubsc*ribe   any (out of/from inside/from) any rd

if (!iobjstr)
  player:tell("Usage:  ", verb, " [<list-of-people/lists>] from <list>");
  return;
elseif ($mail_agent:match_failed(iobj = $mail_agent:match(iobjstr), iobjstr))
  return;
endif
rstrs = dobjstr ? $string_utils:explode(dobjstr) | {"me"};
recips = this:parse_recipients({}, rstrs);
outcomes = iobj:delete_forward(@recips);
if (typeof(outcomes) != LIST)
  player:tell(outcomes);
  return;
endif
removed = {};
for r in [1..length(recips)]
  if (typeof(e = outcomes[r]) == ERR)
    player:tell(verb, " ", recips[r].name, " from ", iobj.name, ":  ", e == E_INVARG ? "Not on list." | e);
  else
    removed = setadd(removed, recips[r]);
  endif
endfor
if (removed)
  player:tell($string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%(name) (%#)", removed)), " removed from ", iobj.name, " (", iobj, ")");
endif
