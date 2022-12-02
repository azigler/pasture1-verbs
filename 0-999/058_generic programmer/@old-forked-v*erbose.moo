#58:@old-forked-v*erbose   any none none rd

"Syntax:  @forked-v*erbose [player]";
"         @forked-v*erbose all wizards";
"";
"For a normal player, shows all the tasks you have waiting in your queue, especially those forked or suspended. A wizard will see all the tasks of all the players unless the optional argument is provided. For a task which has suspended, and not a fresh fork, shows the full callers() stack.";
"The second form is only usable by wizards and provides an output of all tasks owned by characters who are .wizard=1. Useful to find a task that may get put in a random queue due to $wiz_utils:random_wizard. Or even finding verbs that run with wizard permissions that shouldn't be.";
set_task_perms(player);
if (!dobjstr)
  tasks = queued_tasks();
elseif (dobjstr == "all wizards" && player.wizard)
  tasks = {};
  for t in (queued_tasks())
    if (valid(t[5]) && t[5].wizard)
      tasks = {@tasks, t};
    endif
    $command_utils:suspend_if_needed(1);
  endfor
elseif ($command_utils:player_match_result(dobj = $string_utils:match_player(dobjstr), dobjstr)[1])
  return;
elseif (typeof(tasks = $wiz_utils:queued_tasks(dobj)) != LIST)
  player:notify(tostr(verb, " ", dobj.name, "(", dobj, "):  ", tasks));
  return;
endif
if (tasks)
  su = $string_utils;
  player:notify("Queue ID    Start Time            Owner         Verb (Line) [This]");
  player:notify("--------    ----------            -----         -----------------");
  now = time();
  for task in (tasks)
    $command_utils:suspend_if_needed(0);
    {q_id, start, nu, nu2, owner, vloc, vname, lineno, this, ?size = 0} = task;
    time = start >= now ? ctime(start)[5..24] | su:left(start == -1 ? "Reading input ..." | tostr(now - start, " seconds ago..."), 20);
    owner_name = valid(owner) ? owner.name | tostr("Dead ", owner);
    player:notify(tostr(su:left(tostr(q_id), 10), "  ", time, "  ", su:left(owner_name, 12), "  ", vloc, ":", vname, " (", lineno, ")", this != vloc ? tostr(" [", this, "]") | ""));
    if (stack = `task_stack(q_id, 1) ! E_INVARG => 0')
      for frame in (listdelete(stack, 1))
        {sthis, svname, sprogger, svloc, splayer, slineno} = frame;
        player:notify(tostr("                    Called By...  ", su:left(valid(sprogger) ? sprogger.name | tostr("Dead ", sprogger), 12), "  ", svloc, ":", svname, sthis != svloc ? tostr(" [", sthis, "]") | "", " (", slineno, ")"));
      endfor
    endif
  endfor
  player:notify("-----------------------------------------------------------------");
else
  player:notify("No tasks.");
endif
