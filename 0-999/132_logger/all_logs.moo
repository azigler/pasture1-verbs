#132:all_logs   this none this xd

":all_logs(who): Returns a list of all logs readable by who.";
{?who = player} = args;
!caller_perms().wizard && raise(E_PERM);
!$object_utils:isa(who, $player) && raise(E_PERM);
logs = {};
for p in (properties(this))
  if (`p[$ - 3..$] ! ANY => ""' == "_log" && this:is_log_readable_by(who, p[1..$ - 4]))
    logs = {@logs, p[1..$ - 4]};
  endif
  $command_utils:suspend_if_needed(0);
endfor
return logs;
"Last modified Mon Mar 12 04:22:42 2018 CDT by Jason Perino (#91@ThetaCore).";
