#59:show_who_listing   this none this rxd

":show_who_listing(players[,more_players])";
" prints a listing of the indicated players.";
" For players in the first list, idle/connected times are shown if the player is logged in, otherwise the last_disconnect_time is shown.  For players in the second list, last_disconnect_time is shown, no matter whether the player is logged in.";
{plist, ?more_plist = {}} = args;
idles = itimes = offs = otimes = {};
argstr = dobjstr = iobjstr = prepstr = "";
for p in (more_plist)
  if (!valid(p))
    caller:notify(tostr(p, " <invalid>"));
  elseif (typeof(t = `p.last_disconnect_time ! E_PROPNF') == INT)
    if (!(p in offs))
      offs = {@offs, p};
      otimes = {@otimes, {-t, -t, p}};
    endif
  elseif (is_player(p))
    caller:notify(tostr(p.name, " (", p, ") ", t == E_PROPNF ? "is not a $player." | "has a garbled .last_disconnect_time."));
  else
    caller:notify(tostr(p.name, " (", p, ") is not a player."));
  endif
endfor
for p in (plist)
  if (p in offs)
  elseif (!valid(p))
    caller:notify(tostr(p, " <invalid>"));
  elseif (typeof(i = `idle_seconds(p) ! ANY') != ERR)
    if (!(p in idles))
      idles = {@idles, p};
      itimes = {@itimes, {i, connected_seconds(p), p}};
    endif
  elseif (typeof(t = `p.last_disconnect_time ! E_PROPNF') == INT)
    offs = {@offs, p};
    otimes = {@otimes, {-t, -t, p}};
  elseif (is_player(p))
    caller:notify(tostr(p.name, " (", p, ") not logged in.", t == E_PROPNF ? "  Not a $player." | "  Garbled .last_disconnect_time."));
  else
    caller:notify(tostr(p.name, " (", p, ") is not a player."));
  endif
endfor
if (!(idles || offs))
  return 0;
endif
idles = $list_utils:sort_alist(itimes);
offs = $list_utils:sort_alist(otimes);
"...";
"... calculate widths...";
"...";
headers = {"Player name", @idles ? {"Connected", "Idle time"} | {"Last disconnect time", ""}, "Location"};
total_width = `caller:linelen() ! ANY => 0' || 79;
max_name = total_width / 4;
name_width = length(headers[1]);
names = locations = {};
for lst in ({@idles, @offs})
  $command_utils:suspend_if_needed(0);
  p = lst[3];
  namestr = tostr(p.name[1..min(max_name, $)], " (", p, ")");
  name_width = max(length(namestr), name_width);
  names = {@names, namestr};
  if (typeof(wlm = `p.location:who_location_msg(p) ! ANY') != STR)
    wlm = valid(p.location) ? p.location.name | tostr("** Nowhere ** (", p.location, ")");
  endif
  locations = {@locations, wlm};
endfor
time_width = 3 + (offs ? 12 | length("59 minutes"));
before = {0, w1 = 3 + name_width, w2 = w1 + time_width, w2 + time_width};
"...";
"...print headers...";
"...";
su = $string_utils;
tell1 = headers[1];
tell2 = su:space(tell1, "-");
for j in [2..4]
  tell1 = su:left(tell1, before[j]) + headers[j];
  tell2 = su:left(tell2, before[j]) + su:space(headers[j], "-");
endfor
caller:notify(tell1[1..min($, total_width)]);
caller:notify(tell2[1..min($, total_width)]);
"...";
"...print lines...";
"...";
active = 0;
for i in [1..total = (ilen = length(idles)) + length(offs)]
  if (i <= ilen)
    lst = idles[i];
    if (lst[1] < 5 * 60)
      active = active + 1;
    endif
    l = {names[i], su:from_seconds(lst[2]), su:from_seconds(lst[1]), locations[i]};
  else
    lct = offs[i - ilen][3].last_connect_time;
    ldt = offs[i - ilen][3].last_disconnect_time;
    ctime = `caller:ctime(ldt) ! ANY => 0' || ctime(ldt);
    l = {names[i], lct <= time() ? ctime | "Never", "", locations[i]};
    if (i == ilen + 1 && idles)
      caller:notify(su:space(before[2]) + "------- Disconnected -------");
    endif
  endif
  tell1 = l[1];
  for j in [2..4]
    tell1 = su:left(tell1, before[j]) + l[j];
  endfor
  caller:notify(tell1[1..min($, total_width)]);
  if ($command_utils:running_out_of_time())
    if ($login:is_lagging())
      "Check lag two ways---global lag, but we might still fail due to individual lag of the queue this runs in, so check again later.";
      caller:notify(tostr("Plus ", total - i, " other players (", total, " total; out of time and lag is high)."));
      return;
    endif
    now = time();
    suspend(0);
    if (time() - now > 10)
      caller:notify(tostr("Plus ", total - i, " other players (", total, " total; out of time and lag is high)."));
      return;
    endif
  endif
endfor
"...";
"...epilogue...";
"...";
caller:notify("");
if (total == 1)
  active_str = ", who has" + (active == 1 ? "" | " not");
else
  if (active == total)
    active_str = active == 2 ? "s, both" | "s, all";
  elseif (active == 0)
    active_str = "s, none";
  else
    active_str = tostr("s, ", active);
  endif
  active_str = tostr(active_str, " of whom ha", active == 1 ? "s" | "ve");
endif
caller:notify(tostr("Total: ", total, " player", active_str, " been active recently."));
return total;
