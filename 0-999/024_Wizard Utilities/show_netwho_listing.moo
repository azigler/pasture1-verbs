#24:show_netwho_listing   this none this rxd

":show_netwho_listing(tell,player_list)";
" prints a listing of the indicated players showing connect sites.";
{who, unsorted} = args;
if (!caller_perms().wizard)
  return E_PERM;
elseif (!unsorted)
  return;
endif
su = $string_utils;
au = $ansi_utils;
alist = {};
footnotes = {};
nwidth = length("Player name");
for u in (unsorted)
  $command_utils:suspend_if_needed(0);
  if (u.programmer)
    pref = "% ";
    footnotes = setadd(footnotes, "prog");
  else
    pref = "  ";
  endif
  if (u in connected_players())
    lctime = ctime(time() - connected_seconds(u));
    where = $string_utils:connection_hostname(connection_name(u));
  else
    lctime = ctime(u.last_connect_time);
    where = u.last_connect_place;
  endif
  u3 = {tostr(pref, su:nn(u)), lctime[5..10] + lctime[20..24]};
  nwidth = max(au:length(u3[1]), nwidth);
  if ($login:blacklisted(where))
    where = "(*) " + where;
    footnotes = setadd(footnotes, "black");
  elseif ($login:graylisted(where))
    where = "(+) " + where;
    footnotes = setadd(footnotes, "gray");
  endif
  alist = {@alist, {@u3, where}};
endfor
alist = $list_utils:sort_alist_suspended(0, alist, 3);
$command_utils:suspend_if_needed(0);
headers = {"Player name", "Last Login", "From Where"};
before = {0, nwidth + 3, nwidth + length(ctime(0)) - 11};
tell1 = "  " + headers[1];
tell2 = "  " + su:space(headers[1], "-");
for j in [2..3]
  tell1 = su:left(tell1, before[j]) + headers[j];
  tell2 = su:left(tell2, before[j]) + su:space(headers[j], "-");
endfor
who:notify(tell1);
who:notify(tell2);
for a in (alist)
  $command_utils:suspend_if_needed(0);
  tell1 = a[1];
  for j in [2..3]
    tell1 = su:left(tell1, before[j]) + a[j];
  endfor
  who:notify(tell1[1..min($, player:linelen())]);
endfor
if (footnotes)
  who:notify("");
  if ("prog" in footnotes)
    who:notify(" %  == programmer.");
  endif
  if ("black" in footnotes)
    who:notify("(*) == blacklisted site.");
  endif
  if ("gray" in footnotes)
    who:notify("(+) == graylisted site.");
  endif
endif
