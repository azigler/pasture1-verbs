#134:"@kill-timer @rmtimer"   any none none rxd

"Usage: @kill-timer <spec1>[,<spec2>[,...]]]";
"@kill-timer all";
"Kill one or more timer tasks.";
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
  tasklist = lu:slice(this.timer_tasks);
else
  tasklist = this:search_timer_tasks(argstr);
endif
if (!tasklist)
  argstr && player:tell(argstr != "all" ? "No timer tasks matched your query." | "There are no timer tasks.");
else
  for t in (tasklist)
    if (!`this:kill_timer(t) ! E_INVARG')
      player:tell("Timer task " + tostr(t) + " killed.");
    else
      player:tell("Timer task " + tostr(t) + " doesn't exist.");
    endif
  endfor
endif
"Last modified Mon Sep 11 09:39:15 2017 CDT by Jason Perino (#91@ThetaCore).";
