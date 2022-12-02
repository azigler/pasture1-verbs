#57:@shutdown   any any any rd

if (!player.wizard)
  player:notify("Sorry.");
  return;
elseif ($code_utils:task_valid($wiz_utils.shutdown_task))
  player:notify(tostr("Shutdown already in progress.  The MOO will be shut down in ", $time_utils:english_time($server["shutdown_time"] - time()), ", by ", $wiz_utils.shutdown_message));
  return;
endif
if (s = match(argstr, "^in +%([0-9]+%)%( +%|$%)"))
  bounds = s[3][1];
  delay = toint(argstr[bounds[1]..bounds[2]]);
  argstr = argstr[s[2] + 1..$];
else
  delay = 2;
endif
if (!$command_utils:yes_or_no(tostr("Do you really want to shut down the server in ", delay, " minutes?")))
  player:notify("Aborted.");
  return;
endif
announce_times = {};
if (delay > 0)
  while (delay > 0)
    announce_times = {@announce_times, delay * 60};
    delay = delay / 2;
  endwhile
  announce_times = {@announce_times, 30, 10};
  $server["shutdown_time"] = time() + announce_times[1];
endif
$wiz_utils.shutdown_message = tostr(player.name, " (", player, "): ", argstr);
$wiz_utils.shutdown_task = task_id();
for i in [1..length(announce_times)]
  base_msg = tostr("*** The server will be shut down by ", player.name, " (", player, ") in ", $time_utils:english_time(announce_times[i]), ":");
  msg = {base_msg, @$generic_editor:fill_string("*** " + argstr, length(base_msg) - 4, "*** ")};
  "...use raw notify() since :notify() verb could be broken...";
  for p in (connected_players())
    for line in (msg)
      notify(p, line);
    endfor
    $command_utils:suspend_if_needed(0);
  endfor
  suspend(announce_times[i] - {@announce_times, 0}[i + 1]);
endfor
for p in (connected_players())
  notify(p, tostr("*** Server shutdown by ", $wiz_utils.shutdown_message, " ***"));
  boot_player(p);
endfor
suspend(0);
$wiz_utils.shutdown_task = E_NONE;
set_task_perms(player);
shutdown(argstr);
