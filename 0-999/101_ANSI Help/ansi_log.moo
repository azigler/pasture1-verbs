#101:ansi_log   this none this rxd

help = {};
linelen = player:linelen();
log = $ansi_utils.(verb);
vmax = 8 + max(@$list_utils:map_builtin($list_utils:slice(log, 1), "length"));
for x in (log)
  help = {@help, tostr($string_utils:left(tostr("Version ", x[1]), vmax), "  ", $string_utils:left($time_utils:time_sub("$N, $Y", x[2]), 25), x[3])};
  for l in (typeof(x[4]) == LIST ? x[4] | {x[4]})
    for i in ($generic_editor:fill_string(l, linelen - vmax - 2))
      help = {@help, tostr($string_utils:space(vmax + 2), i)};
    endfor
  endfor
  help = {@help, ""};
  $command_utils:suspend_if_needed(0);
endfor
return help;
