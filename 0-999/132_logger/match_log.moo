#132:match_log   this none this xd

":match_log([who,] log): Find all matching logs readable by who.";
{?who = player, log} = args;
!caller_perms().wizard && raise(E_PERM);
!$object_utils:isa(who, $player) && raise(E_INVARG);
matches = {};
if (!log)
  return matches;
endif
for l in (this:all_logs(who))
  if (this:is_log_readable_by(who, l) && (log == l || index(l, log)))
    matches = {@matches, l};
  endif
endfor
return matches;
"Last modified Mon Mar 12 04:24:23 2018 CDT by Jason Perino (#91@ThetaCore).";
