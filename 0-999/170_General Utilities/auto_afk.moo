#170:auto_afk   this none this rxd

":auto_afk()";
"Every minute or so, iterate through connected players and see if they've been idle for .autoafk_options max_time (default 10 minutes) or more. If so, afk them.";
"Not 100% accurate, time-wise, but close enough that I doubt anybody will care.";
"-- Constants (faster than #0 property lookups each iteration of the loop) --";
GC = $global_chat;
AFK_LIST = GC.afk_list;
DEFAULT_AFK_TIME = 60 * 10;
" -- ";
for x in (connected_players())
  yin();
  if (`x.autoafk_options["auto_afk"] ! E_RANGE' && !(x in AFK_LIST) && idle_seconds(x) >= `x.autoafk_options["max_time"] ! E_RANGE => DEFAULT_AFK_TIME')
    "I don't want to mess with the afk command too much. Luckily, wizards can override the player variable. So we can do that and call afk directly. Force_input would also work but people generally frown on that for whatever reason.";
    fork (0)
      player = x;
      GC:afk();
    endfork
  endif
endfor
fork (60)
  this:(verb)(@args);
endfork
