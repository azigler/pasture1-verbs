#24:queued_tasks   this none this rxd

":queued_tasks(player) => list of queued tasks for that player.";
"shouldn't the server builtin should work this way?  oh well";
set_task_perms(caller_perms());
if (typeof(e = `set_task_perms(who = args[1]) ! ANY') == ERR)
  return e;
elseif (who.wizard)
  tasks = {};
  for t in (queued_tasks())
    if (t[5] == who)
      tasks = {@tasks, t};
    endif
  endfor
  return tasks;
else
  return queued_tasks();
endif
