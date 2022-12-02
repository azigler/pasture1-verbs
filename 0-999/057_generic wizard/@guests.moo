#57:@guests   any none none rd

set_task_perms(player);
n = dobjstr == "all" ? 0 | $code_utils:toint(dobjstr || "20");
if (caller != this)
  player:notify("You lose.");
elseif (n == E_TYPE && index("now", dobjstr) != 1)
  player:notify(tostr("Usage:  ", verb, " <number>  (where <number> indicates how many entries to look at in the guest log)"));
  player:notify(tostr("Usage:  ", verb, " now (to see information about currently connected guests only)"));
elseif (!dobjstr || index("now", dobjstr) != 1)
  $guest_log:last(n);
else
  "*way* too much copied code in here from @who...  Sorry.  --yduJ";
  su = $string_utils;
  conn = connected_players();
  unsorted = {};
  for g in ($object_utils:leaves($guest))
    if (g in conn)
      unsorted = {@unsorted, g};
    endif
  endfor
  if (!unsorted)
    player:tell("No guests found.");
    return;
  endif
  footnotes = {};
  alist = {};
  nwidth = length("Player name");
  for u in (unsorted)
    pref = u.programmer ? "% " | "  ";
    u.programmer && (footnotes = setadd(footnotes, "prog"));
    u3 = {tostr(pref, u.name, " (", u, ")"), su:from_seconds(connected_seconds(u)), su:from_seconds(idle_seconds(u)), where = $string_utils:connection_hostname(u)};
    nwidth = max(length(u3[1]), nwidth);
    if ($login:blacklisted(where))
      where = "(*) " + where;
      footnotes = setadd(footnotes, "black");
    elseif ($login:graylisted(where))
      where = "(+) " + where;
      footnotes = setadd(footnotes, "gray");
    endif
    alist = {@alist, u3};
    $command_utils:suspend_if_needed(0);
  endfor
  alist = $list_utils:sort_alist_suspended(0, alist, 3);
  $command_utils:suspend_if_needed(0);
  headers = {"Player name", "Connected", "Idle Time", "From Where"};
  time_width = length("59 minutes") + 2;
  before = {0, w1 = nwidth + 3, w2 = w1 + time_width, w3 = w2 + time_width};
  tell1 = "  " + headers[1];
  tell2 = "  " + su:space(headers[1], "-");
  for j in [2..4]
    tell1 = su:left(tell1, before[j]) + headers[j];
    tell2 = su:left(tell2, before[j]) + su:space(headers[j], "-");
  endfor
  player:notify(tell1);
  player:notify(tell2);
  active = 0;
  for a in (alist)
    $command_utils:suspend_if_needed(0);
    tell1 = a[1];
    for j in [2..4]
      tell1 = su:left(tell1, before[j]) + tostr(a[j]);
    endfor
    player:notify(tell1[1..min($, 79)]);
  endfor
  if (footnotes)
    player:notify("");
    if ("prog" in footnotes)
      player:notify(" %  == programmer.");
    endif
    if ("black" in footnotes)
      player:notify("(*) == blacklisted site.");
    endif
    if ("gray" in footnotes)
      player:notify("(+) == graylisted site.");
    endif
  endif
  player:tell("@guests display complete.");
endif
