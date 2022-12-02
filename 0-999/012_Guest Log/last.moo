#12:last   this none this rxd

":last([n,[guest_list]])";
"print list of the last n entries in the guest log";
" (use n=0 if you want all entries)";
" optional second arg limits listing to the specified guest(s)";
set_task_perms(caller_perms());
{?howmany = 0, ?which = 0} = args;
howmany = min(howmany || $maxint, length($guest_log.connections));
if (!caller_perms().wizard)
  player:notify("Sorry.");
else
  current = {};
  listing = {};
  last = 0;
  for c in ($guest_log.connections[1..howmany])
    if (which && !(c[1] in which))
    elseif (c[2])
      "...login...";
      if (a = $list_utils:assoc(c[1], current))
        listing[a[2]][3] = c[3];
        current = setremove(current, a);
      else
        listing = {@listing, {c[1], c[4], c[3], $object_utils:connected(c[1]) ? -idle_seconds(c[1]) | 1}};
        last = last + 1;
      endif
    else
      "...logout...";
      listing = {@listing, {c[1], c[4], 0, c[3]}};
      last = last + 1;
      if (i = $list_utils:iassoc(c[1], current))
        current[i][2] = last;
      else
        current = {@current, {c[1], last}};
      endif
    endif
    $command_utils:suspend_if_needed(2);
  endfor
  su = $string_utils;
  player:notify(su:left(su:left(su:left("Guest", 20) + "Connected", 36) + "Idle/Disconn.", 52) + "From");
  player:notify(su:left(su:left(su:left("-----", 20) + "---------", 36) + "-------------", 52) + "----");
  for l in (listing)
    on = l[3] ? (ct = ctime(l[3]))[1..3] + ct[9..19] | "earlier";
    off = l[4] > 0 ? (ct = ctime(l[4]))[1..3] + ct[9..19] | "  " + $string_utils:from_seconds(-l[4]);
    player:notify(su:left(su:left(su:right(tostr(strsub(l[1].name, "uest", "."), " (", l[1], ")  "), -20) + on, 36) + off, 52) + l[2]);
    $command_utils:suspend_if_needed(2);
  endfor
endif
