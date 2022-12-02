#50:@flush   this any any rxd

"@flush <editor>";
"@flush <editor> at <month> <day>";
"@flush <editor> at <weekday>";
"The first form removes all sessions from the editor; the other two forms remove everything older than the given date.";
if (caller_perms() != #-1 && caller_perms() != player)
  raise(E_PERM);
elseif (!$perm_utils:controls(player, this))
  player:tell("Only the owner of the editor can do a ", verb, ".");
  return;
endif
if (!prepstr)
  player:tell("Trashing all sessions.");
  this:kill_all_sessions();
elseif (prepstr != "at")
  player:tell("Usage:  ", verb, " ", dobjstr, " [at [mon day|weekday]]");
else
  p = prepstr in args;
  if (t = $time_utils:from_day(iobjstr, -1))
  elseif (t = $time_utils:from_month(args[p + 1], -1))
    if (length(args) > p + 1)
      if (!(n = toint(args[p + 2])))
        player:tell(args[p + 1], " WHAT?");
        return;
      endif
      t = t + (n - 1) * 86400;
    endif
  else
    player:tell("couldn't parse date");
    return;
  endif
  this:do_flush(t, "noisy");
endif
player:tell("Done.");
