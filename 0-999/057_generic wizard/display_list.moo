#57:display_list   this none this rxd

if (caller != this && !caller_perms().wizard)
  return E_PERM;
endif
which = args[1];
slist = {};
if (s = $login.(which)[1])
  slist = {@slist, "--- Subnets ---", @s};
endif
if (s = $login.(which)[2])
  slist = {@slist, "--- Domains ---", @s};
endif
if (s = $login.("temporary_" + which)[1])
  slist = {@slist, "--- Temporary Subnets ---"};
  for d in (s)
    slist = {@slist, tostr(d[1], " until ", $time_utils:time_sub("$1/$3 $H:$M", d[2] + d[3]))};
    $command_utils:suspend_if_needed(2);
  endfor
endif
if (s = $login.("temporary_" + which)[2])
  slist = {@slist, "--- Temporary Domains ---"};
  for d in (s)
    slist = {@slist, tostr(d[1], " until ", $time_utils:time_sub("$1/$3 $H:$M", d[2] + d[3]))};
    $command_utils:suspend_if_needed(2);
  endfor
endif
if (slist)
  player:notify_lines($string_utils:columnize(slist, 2));
else
  player:notify(tostr("The ", which, " is empty."));
endif
