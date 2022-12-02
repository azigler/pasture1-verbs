#6:"?* help info*rmation @help"   any any any rxd

set_task_perms(callers() ? caller_perms() | player);
"...this code explicitly relies on being !d in several places...";
if (index(verb, "?") != 1 || length(verb) <= 1)
  what = $string_utils:trimr(argstr);
elseif (argstr)
  what = tostr(verb[2..$], " ", $string_utils:trimr(argstr));
else
  what = verb[2..$];
endif
"...find a db that claims to know about `what'...";
dblist = $code_utils:help_db_list();
result = $code_utils:help_db_search(what, dblist);
if (!result)
  "... note: all of the last-resort stuff...";
  "... is now located on $help:find_topics/get_topic...";
  $wiz_utils:missed_help(what, result);
  player:notify(tostr("Sorry, but no help is available on `", what, "'."));
elseif (result[1] == $ambiguous_match)
  $wiz_utils:missed_help(what, result);
  player:notify_lines(tostr("Sorry, but the topic-name `", what, "' is ambiguous.  I don't know which of the following topics you mean:"));
  for x in ($help:columnize(@$help:sort_topics(result[2])))
    player:notify(tostr("   ", x));
  endfor
else
  {help, topic} = result;
  if (topic != what)
    player:notify(tostr("Showing help on `", topic, "':"));
    player:notify("----");
  endif
  dblist = dblist[1 + (help in dblist)..$];
  if (1 == (text = help:get_topic(topic, dblist)))
    "...get_topic took matters into its own hands...";
  elseif (text)
    "...these can get long...";
    for line in (typeof(text) == LIST ? text | {text})
      if (typeof(line) != STR)
        player:notify("Odd results from help -- complain to a wizard.");
      else
        player:notify(line);
      endif
      $command_utils:suspend_if_needed(0);
    endfor
  else
    player:notify(tostr("Help DB ", help, " thinks it knows about `", what, "' but something's messed up."));
    player:notify(tostr("Tell ", help.owner.wizard ? "" | tostr(help.owner.name, " (", help.owner, ") or "), "a wizard."));
  endif
endif
