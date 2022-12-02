#58:"@kill @killq*uiet"   any none none rd

"Kills one or more tasks.";
"Arguments:";
"   object:verb -- kills all tasks which were started from that object and verb.";
"   all -- kills all tasks owned by invoker";
"   all player-name -- wizard variant:  kills all tasks owned by player.";
"   all everyone -- wizard variant:  really kills all tasks.";
"   Integer taskid -- kills the specifically named task.";
"   soon [integer] -- kills all tasks scheduled to run in the next [integer] seconds, which defaults to 60.";
"   %integer -- kills all tasks which end in the digits contained in integer.";
"   The @killquiet alias kills tasks without the pretty printout if more than one task is being killed.";
set_task_perms(player);
quiet = index(verb, "q");
if (length(args) == 0)
  player:notify_lines({tostr("Usage:  ", verb, " [object]:[verb]"), tostr("        ", verb, " task_id"), tostr("        ", verb, " soon [number-of-seconds]", player.wizard ? " [everyone|<player name>]" | ""), tostr("        ", verb, " all", player.wizard ? " [everyone|<player name>]" | "")});
  return;
elseif (taskid = toint(args[1]))
elseif (all = args[1] == "all")
  everyone = 0;
  realplayer = player;
  if (player.wizard && length(args) > 1)
    realplayer = $string_utils:match_player(args[2]);
    everyone = args[2] == "everyone";
    if (!valid(realplayer) && !everyone)
      $command_utils:player_match_result(realplayer, args[2]);
      return;
    elseif (!everyone)
      set_task_perms(realplayer);
    endif
  endif
elseif (soon = args[1] == "soon")
  realplayer = player;
  if (length(args) > 1)
    soon = toint(args[2]);
    if (soon <= 0 && !player.wizard)
      player:notify(tostr("Usage:  ", verb, " soon [positive-number-of-seconds]"));
      return;
    elseif (player.wizard)
      result = this:kill_aux_wizard_parse(@args[2..$]);
      soon = result[1];
      if (result[1] < 0)
        "already gave them an error message";
        return;
      elseif (result[2] == 1)
        everyone = 1;
      else
        everyone = 0;
        set_task_perms(result[2]);
        realplayer = result[2];
      endif
    endif
  else
    soon = 60;
    everyone = 0;
  endif
elseif (percent = args[1][1] == "%")
  l = length(args[1]);
  digits = toint(args[1][2..l]);
  percent = toint("1" + "0000000000"[1..l - 1]);
elseif (colon = index(argstr, ":"))
  whatstr = argstr[1..colon - 1];
  vrb = argstr[colon + 1..$];
  if (whatstr)
    what = player:my_match_object(whatstr);
  endif
else
  player:notify_lines({tostr("Usage:  ", verb, " [object]:[verb]"), tostr("        ", verb, " task_id"), tostr("        ", verb, " soon [number-of-seconds]", player.wizard ? " [everyone|<player name>]" | ""), tostr("        ", verb, " all", player.wizard ? " [\"everyone\"|<player name>]" | "")});
  return;
endif
"OK, parsed the line, and punted them if it was bogus.  This verb could have been a bit shorter at the expense of readability.  I think it's getting towards unreadable as is.  At this point we've set_task_perms'd, and set up an enormous number of local variables.  Evaluate them in the order we set them, and we should never get var not found.";
queued_tasks = queued_tasks();
killed = 0;
if (taskid)
  try
    kill_task(taskid);
    player:notify(tostr("Killed task ", taskid, "."));
    killed = 1;
  except error (ANY)
    player:notify(tostr("Can't kill task ", taskid, ": ", error[2]));
  endtry
elseif (all)
  for task in (queued_tasks)
    if (everyone || realplayer == task[5])
      `kill_task(task[1]) ! ANY';
      killed = killed + 1;
      if (!quiet)
        this:_kill_task_message(task);
      endif
    endif
    $command_utils:suspend_if_needed(3, "... killing tasks");
  endfor
elseif (soon)
  now = time();
  for task in (queued_tasks)
    if (task[2] - now < soon && (!player.wizard || (everyone || realplayer == task[5])))
      `kill_task(task[1]) ! ANY';
      killed = killed + 1;
      if (!quiet)
        this:_kill_task_message(task);
      endif
    endif
    $command_utils:suspend_if_needed(3, "... killing tasks");
  endfor
elseif (percent)
  for task in (queued_tasks)
    if (digits == task[1] % percent)
      `kill_task(task[1]) ! ANY';
      killed = killed + 1;
      if (!quiet)
        this:_kill_task_message(task);
      endif
    endif
    $command_utils:suspend_if_needed(3, "... killing tasks");
  endfor
elseif (colon || vrb || whatstr)
  for task in (queued_tasks)
    if (whatstr == "" || (valid(task[6]) && index(task[6].name, whatstr) == 1) || (valid(task[9]) && index(task[9].name, whatstr) == 1) || task[9] == what || task[6] == what && (vrb == "" || index(" " + strsub(task[7], "*", ""), " " + vrb) == 1))
      `kill_task(task[1]) ! ANY';
      killed = killed + 1;
      if (!quiet)
        this:_kill_task_message(task);
      endif
    endif
    $command_utils:suspend_if_needed(3, "... killing tasks");
  endfor
else
  player:notify("Something is funny; I didn't understand your @kill command.  You shouldn't have gotten here.  Please send yduJ mail saying you got this message from @kill, and what you had typed to @kill.");
endif
if (!killed)
  player:notify("No tasks killed.");
elseif (quiet)
  player:notify(tostr("Killed ", killed, " tasks."));
endif
