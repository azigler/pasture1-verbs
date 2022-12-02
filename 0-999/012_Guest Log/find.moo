#12:find   this none this rxd

":find(guest_id,time)";
" => site name of guest logged in at that time";
" => 0 if not logged in";
" => E_NACC if this is earlier than the earliest guest recorded";
set_task_perms(caller_perms());
{who, when} = args;
if (!caller_perms().wizard)
  raise(E_PERM);
else
  found = who in connected_players() ? $string_utils:connection_hostname(who.last_connect_place) | 0;
  for c in ($guest_log.connections)
    if (c[3] < when)
      return found;
    elseif (c[1] != who)
      "... different guest...";
    elseif (c[2])
      "...login...";
      if (c[3] == when)
        return found;
      endif
      found = 0;
    else
      "...logout...";
      found = c[4];
    endif
  endfor
  return E_NACC;
endif
