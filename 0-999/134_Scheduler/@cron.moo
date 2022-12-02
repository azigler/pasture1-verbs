#134:@cron   any none none rxd

"Usage: @cron";
"@cron <spec1>[,<spec2>[,...]]]";
"Check Cron task scheduler status.";
"You may search the scheduler by task ID, by verb reference, or by player name.";
"Simultaneous queries are possible by separating the queries with a comma (,)";
lu = $list_utils;
su = $string_utils;
player = callers()[$][5];
if (!player.wizard)
  return player:tell("No.");
endif
if (!argstr)
  ll = `player:linelen() ! ANY => 79';
  tasks = length(this.cron_tasks);
  player:tell(su:space(ll, "-"));
  player:tell(su:center("It is now " + ctime()[5..$] + ".", ll));
  player:tell(su:center("The Cron task scheduler is " + ($code_utils:task_valid(this.cron_task) ? "active." | "inactive."), ll));
  player:tell(su:center("There " + (tasks == 1 ? "is " | "are ") + (!tasks ? "no" | tostr(tasks)) + " Cron " + (tasks == 1 ? "task." | "tasks."), ll));
  player:tell(su:space(ll, "-"));
  tasklist = lu:slice(this.cron_tasks);
else
  tasklist = this:search_cron_tasks(argstr);
endif
if (!tasklist)
  argstr && player:tell("No Cron tasks matched your query.");
else
  for t in (tasklist)
    info = this:get_cron_display(t);
    if (!info)
      player:tell("Cron task " + tostr(t) + " doesn't exist.");
    else
      player:tell_lines(info);
    endif
  endfor
endif
"Last modified Sat Sep  9 20:16:33 2017 CDT by Jason Perino (#91@ThetaCore).";
