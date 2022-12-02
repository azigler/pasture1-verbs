#99:show_who_listing   this none this rx

":show_who_listing(players[,more_players])";
" prints a listing of the indicated players.";
" For players in the first list, idle/connected times are shown if the player is logged in, otherwise the last_disconnect_time is shown.  For players in the second list, last_disconnect_time is shown, no matter whether the player is logged in.";
idles = itimes = offs = otimes = listing = {};
for p in (args[2])
  if (!valid(p))
    listing = {@listing, tostr(p, " <invalid>")};
  elseif (typeof(t = p.last_disconnect_time) == NUM)
    p in offs || ((offs = {@offs, p}) && (otimes = {@otimes, {-t, -t, p}}));
  elseif (is_player(p))
    listing = {@listing, tostr(p.name, " (", p, ") ", t == E_PROPNF ? "is not a $player." | "has a garbled .last_disconnect_time.")};
  else
    listing = {@listing, tostr(p.name, " (", p, ") is not a player.")};
  endif
endfor
for p in (args[1])
  if (p in offs)
  elseif (!valid(p))
    listing = {@listing, tostr(p, " <invalid>")};
  elseif (typeof(i = idle_seconds(p)) != ERR && p in connected_players())
    p in idles || ((idles = {@idles, p}) && (itimes = {@itimes, {i, connected_seconds(p), p}}));
  elseif (typeof(t = p.last_disconnect_time) == NUM)
    (offs = {@offs, p}) && (otimes = {@otimes, {-t, -t, p}});
  elseif (is_player(p))
    listing = {@listing, tostr(p.name, " (", p, ") not logged in.", t == E_PROPNF ? "  Not a $player." | "  Garbled .last_disconnect_time.")};
  else
    listing = {@listing, tostr(p.name, " (", p, ") is not a player.")};
  endif
endfor
if (!(idles || offs))
  return 0;
endif
idles = $list_utils:sort_alist(itimes);
offs = $list_utils:sort_alist(otimes);
headers = {"Player name", @idles ? {"Connected", "Idle time"} | {"Last disconnect time", ""}, "Location"};
total_width = caller:linelen() || 79;
max_name = total_width / 4;
name_width = length(headers[1]);
names = locations = {};
for lst in ({@idles, @offs})
  ticks_left() < 2000 || seconds_left() < 2 && suspend(0);
  p = lst[3];
  "p.name and this:ansi_title(p) should be the same length, saves a call to this:length";
  afk_marker = "";
  if (p in $global_chat.afk_list)
    afk_marker = " [AFK]";
  endif
  namestr = tostr(this:cutoff(this:ansi_title(p), 1, min(max_name, z = length(p.name)), 1), " (", p, ")", afk_marker);
  name_width = max(z + 3 + length(tostr(p.name + afk_marker)), name_width);
  names = {@names, namestr};
  typeof(wlm = p.location:who_location_msg(p)) == STR || (wlm = valid(p.location) ? p.location.name | tostr("** Nowhere ** (", p.location, ")"));
  locations = {@locations, wlm};
endfor
time_width = offs ? 15 | 13;
before = {0, w1 = 3 + name_width, w2 = w1 + time_width, w2 + time_width};
su = $string_utils;
tell1 = headers[1];
tell2 = su:space(tell1, "-");
for j in [2..4]
  tell1 = su:left(tell1, before[j]) + headers[j];
  tell2 = su:left(tell2, before[j]) + su:space(headers[j], "-");
endfor
listing = {@listing, tell1[1..min(length(tell1), total_width)]};
listing = {@listing, tell2[1..min(length(tell2), total_width)]};
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
    ctime = caller:ctime(ldt) || ctime(ldt);
    l = {names[i], lct <= time() ? ctime | "Never", "", locations[i]};
    if (i == ilen + 1 && idles)
      listing = {@listing, su:space(before[2]) + "------- Disconnected -------"};
    endif
  endif
  tell1 = l[1];
  for j in [2..4]
    tell1 = su:left(tell1, before[j]) + l[j];
  endfor
  listing = {@listing, this:cutoff(tell1, 1, min(this:length(tell1), total_width))};
  if ($command_utils:running_out_of_time())
    if ($login:is_lagging())
      "Check lag two ways---global lag, but we might still fail due to individual lag of the queue this runs in, so check again later.";
      listing = {@listing, tostr("Plus ", total - i, " other players (", total, " total; out of time and lag is high).")};
      return;
    endif
    now = time();
    suspend(0);
    if (time() - now > 10)
      listing = {@listing, tostr("Plus ", total - i, " other players (", total, " total; out of time and lag is high).")};
      return;
    endif
  endif
endfor
"...";
"...epilogue...";
listing = {@listing, ""};
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
listing = {@listing, tostr("Total: ", total, " player", active_str, " been active recently.")};
vrb = caller == $login || $perm_utils:controls($code_utils:verb_perms(), caller) ? "notify" | "tell";
for line in (listing)
  caller:(vrb)(line);
  seconds_left() < 2 || ticks_left() < 4000 && suspend(0);
endfor
return total;
