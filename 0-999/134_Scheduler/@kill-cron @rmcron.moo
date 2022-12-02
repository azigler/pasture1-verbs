#134:"@kill-cron @rmcron"   any none none rxd

"Usage: @kill-Cron <spec1>[,<spec2>[,...]]]";
"@kill-Cron all";
"Kill one or more Cron tasks.";
su = $string_utils;
lu = $list_utils;
player = callers()[$][5];
if (!player.wizard)
  player:tell("No.");
endif
if (!argstr)
  player:tell("Usage: " + verb + " <spec1>[,<spec2>[,...]]]");
  return player:tell("Or " + verb + " all");
elseif (argstr == "all")
  tasklist = lu:slice(this.cron_tasks);
else
  tasklist = this:search_cron_tasks(argstr);
endif
if (!tasklist)
  argstr && player:tell(argstr != "all" ? "No Cron tasks matched your query." | "There are no Cron tasks.");
else
  for t in (tasklist)
    if (!`this:kill_cron(t) ! E_INVARG')
      player:tell("Cron task " + tostr(t) + " killed.");
    else
      player:tell("Cron task " + tostr(t) + " doesn't exist.");
    endif
  endfor
endif
"Last modified Mon Sep 11 09:38:15 2017 CDT by Jason Perino (#91@ThetaCore).";
