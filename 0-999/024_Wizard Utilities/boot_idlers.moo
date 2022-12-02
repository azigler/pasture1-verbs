#24:boot_idlers   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
"------- constants ---- ";
"20 minutes idle for regular players";
mintime = 60 * 20;
"10 minutes for guests";
minguest = 60 * 10;
"wait 3 minutes before actually booting";
bootdelay = 3;
"start booting when there are 20 less than max players";
threshold = 20;
" ----------------------";
if ($code_utils:task_valid(this.boot_task) && task_id() != this.boot_task)
  "starting a new one: kill the old one";
  kill_task(this.boot_task);
  this.boot_task = 0;
endif
fork taskn (bootdelay * 60 * 3)
  maxplayers = $login:max_connections() - threshold;
  if (length(pl = connected_players()) > maxplayers)
    pll = {};
    plt = {};
    for x in (pl)
      suspend(0);
      min = $object_utils:isa(x, $guest) ? minguest | mintime;
      if ((idle = `idle_seconds(x) ! ANY => 0') > min && !x.wizard && !(x in this.boot_exceptions))
        pll = {x, @pll};
        plt = {idle, @plt};
      endif
    endfor
    if (pll)
      "Sort by idle time, and choose person who has been idle longest.";
      pll = $list_utils:sort(pll, plt);
      booted = pll[$];
      guest = $object_utils:isa(booted, $guest);
      min = guest ? minguest | mintime;
      if (`idle_seconds(booted) ! ANY => 0' > min)
        notify(booted, tostr("*** You've been idle more than ", min / 60, " minutes, and there are more than ", maxplayers, " players connected. If you're still idle and ", $network.moo_name, " is still busy in ", bootdelay, " minute", bootdelay == 1 ? "" | "s", ", you will be booted. ***"));
        fork (60 * bootdelay)
          idle = `idle_seconds(booted) ! ANY => 0';
          if (idle > min && length(connected_players()) > $login:max_connections() - threshold)
            notify(booted, tostr("*** You've been idle too long and ", $network.moo_name, " is still too busy ***"));
            server_log(tostr("IDLE: ", booted.name, " (", booted, ") idle ", idle / 60));
            boot_player(booted);
          endif
        endfork
      endif
    endif
  endif
  this:(verb)(@args);
endfork
this.boot_task = taskn;
"This is set up so that it forks the task first, and this.boot_task is the task_id of whatever is running the idle booter";
