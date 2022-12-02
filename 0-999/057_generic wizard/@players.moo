#57:@players   any any any rd

set_task_perms(player);
"The time below is Oct. 1, 1990, roughly the birthdate of the LambdaMOO server.";
start = 654768000;
now = time();
day = 24 * 60 * 60;
week = 7 * day;
month = 30 * day;
days_objects = days_players = {0, 0, 0, 0, 0, 0, 0};
weeks_objects = weeks_players = {0, 0, 0, 0};
months_objects = months_players = {};
nonplayer_objects = invalid_objects = 0;
always_objects = always_players = 0;
never_objects = never_players = 0;
numo = 0;
if (argstr)
  if (!dobjstr && prepstr == "with" && index("objects", iobjstr) == 1)
    with_objects = 1;
  else
    player:notify(tostr("Usage:  ", verb, " [with objects]"));
    return;
  endif
else
  with_objects = 0;
  players = players();
endif
for i in [1..with_objects ? toint(max_object()) + 1 | length(players)]
  if (with_objects)
    o = toobj(i - 1);
  else
    o = players[i];
  endif
  if ($command_utils:running_out_of_time())
    player:notify(tostr("... ", o));
    suspend(0);
  endif
  if (valid(o))
    numo = numo + 1;
    p = is_player(o) ? o | o.owner;
    if (!valid(p))
      invalid_objects = invalid_objects + 1;
    elseif (!$object_utils:isa(p, $player))
      nonplayer_objects = nonplayer_objects + 1;
    else
      seconds = now - p.last_connect_time;
      days = seconds / day;
      weeks = seconds / week;
      months = seconds / month;
      if (seconds < 0)
        if (is_player(o))
          always_players = always_players + 1;
        else
          always_objects = always_objects + 1;
        endif
      elseif (seconds > now - start)
        if (is_player(o))
          never_players = never_players + 1;
        else
          never_objects = never_objects + 1;
        endif
      elseif (months > 0)
        while (months > length(months_players))
          months_players = {@months_players, 0};
          months_objects = {@months_objects, 0};
        endwhile
        if (is_player(o))
          months_players[months] = months_players[months] + 1;
        endif
        months_objects[months] = months_objects[months] + 1;
      elseif (weeks > 0)
        if (is_player(o))
          weeks_players[weeks] = weeks_players[weeks] + 1;
        endif
        weeks_objects[weeks] = weeks_objects[weeks] + 1;
      else
        if (is_player(o))
          days_players[days + 1] = days_players[days + 1] + 1;
        endif
        days_objects[days + 1] = days_objects[days + 1] + 1;
      endif
    endif
  endif
endfor
player:notify("");
player:notify(tostr("Last connected"));
player:notify(tostr("at least this     Num.     Cumul.   Cumul. %", with_objects ? "     Num.     Cumul.   Cumul. %" | ""));
player:notify(tostr("long ago        players   players   players ", with_objects ? "   objects   objects   objects" | ""));
player:notify(tostr("---------------------------------------------", with_objects ? "--------------------------------" | ""));
su = $string_utils;
col1 = 14;
col2 = 7;
col3 = 10;
col4 = 9;
col5 = 11;
col6 = 11;
col7 = 10;
nump = length(players());
totalp = totalo = 0;
for x in ({{days_players, days_objects, "day", 1}, {weeks_players, weeks_objects, "week", 0}, {months_players, months_objects, "month", 0}})
  pcounts = x[1];
  ocounts = x[2];
  unit = x[3];
  offset = x[4];
  for i in [1..length(pcounts)]
    $command_utils:suspend_if_needed(0);
    j = i - offset;
    player:notify(tostr(su:left(tostr(j, " ", unit, j == 1 ? ":" | "s:"), col1), su:right(pcounts[i], col2), su:right(totalp = totalp + pcounts[i], col3), su:right(totalp * 100 / nump, col4), "%", with_objects ? tostr(su:right(ocounts[i], col5), su:right(totalo = totalo + ocounts[i], col6), su:right(totalo * 100 / numo, col7), "%") | ""));
  endfor
  player:notify("");
endfor
player:notify(tostr(su:left("Never:", col1), su:right(never_players, col2), su:right(totalp = totalp + never_players, col3), su:right(totalp * 100 / nump, col4), "%", with_objects ? tostr(su:right(never_objects, col5), su:right(totalo = totalo + never_objects, col6), su:right(totalo * 100 / numo, col7), "%") | ""));
player:notify(tostr(su:left("Always:", col1), su:right(always_players, col2), su:right(totalp = totalp + always_players, col3), su:right(totalp * 100 / nump, col4), "%", with_objects ? tostr(su:right(always_objects, col5), su:right(totalo = totalo + always_objects, col6), su:right(totalo * 100 / numo, col7), "%") | ""));
with_objects && player:notify(tostr(su:left("Non-player owner:", col1 + col2 + col3 + col4 + 1), su:right(nonplayer_objects, col5), su:right(totalo = totalo + nonplayer_objects, col6), su:right(totalo * 100 / numo, col7), "%"));
with_objects && player:notify(tostr(su:left("Invalid owner:", col1 + col2 + col3 + col4 + 1), su:right(invalid_objects, col5), su:right(totalo = totalo + invalid_objects, col6), su:right(totalo * 100 / numo, col7), "%"));
player:notify("");
