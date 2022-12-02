#57:kill_aux_wizard_parse   this none this rxd

"Auxiliary verb for parsing @kill soon [#-of-seconds] [player | everyone]";
"Args[1] is either # of seconds or player/everyone.";
"Args[2], if it exists, is player/everyone, and forces args[1] to have been # of seconds.";
"Return value: {# of seconds [default 60] , 1 for all, object for player.}";
set_task_perms(caller_perms());
nargs = length(args);
soon = toint(args[1]);
if (nargs > 1)
  everyone = args[2];
elseif (soon <= 0)
  everyone = args[1];
else
  everyone = 0;
endif
if (everyone == "everyone")
  everyone = 1;
elseif (typeof(everyone) == STR)
  result = $string_utils:match_player(everyone);
  if ($command_utils:player_match_failed(result, everyone))
    player:notify(tostr("Usage:  ", callers()[1][2], " soon [number of seconds] [\"everyone\" | player name]"));
    return {-1, -1};
  else
    return {soon ? soon | 60, result};
  endif
endif
return {soon ? soon | 60, everyone ? everyone | player};
