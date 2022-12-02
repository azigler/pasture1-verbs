#6:@lastlog   any none none rxd

"Copied from generic room (#3):@lastlog by Haakon (#2) Wed Dec 30 13:30:02 1992 PST";
if (dobjstr != "")
  dobj = $string_utils:match_player(dobjstr);
  if (!valid(dobj))
    player:tell("Who?");
    return;
  endif
  folks = {dobj};
else
  folks = players();
endif
if (length(folks) > 100)
  player:tell("You have requested a listing of ", length(folks), " players.  That is too long a list; specify individual players you are interested in.");
  return;
endif
day = week = month = ever = never = {};
a_day = 24 * 60 * 60;
a_week = 7 * a_day;
a_month = 30 * a_day;
now = time();
for x in (folks)
  when = x.last_connect_time;
  how_long = now - when;
  if (when == 0 || when > now)
    never = {@never, x};
  elseif (how_long < a_day)
    day = {@day, x};
  elseif (how_long < a_week)
    week = {@week, x};
  elseif (how_long < a_month)
    month = {@month, x};
  else
    ever = {@ever, x};
  endif
endfor
for entry in ({{day, "the last day"}, {week, "the last week"}, {month, "the last 30 days"}, {ever, "recorded history"}})
  if (entry[1])
    player:tell("Players who have connected within ", entry[2], ":");
    for x in (entry[1])
      player:tell("  ", x.name, " last connected ", ctime(x.last_connect_time), ".");
    endfor
  endif
endfor
if (never)
  player:tell("Players who have never connected:");
  player:tell("  ", $string_utils:english_list($list_utils:map_prop(never, "name")));
endif
