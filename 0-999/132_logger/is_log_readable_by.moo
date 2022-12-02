#132:is_log_readable_by   this none this xd

":is_log_readable_by([who,] log): Get the readability of log by who.";
{?who = player, log} = args;
!caller_perms().wizard && raise(E_PERM);
!$object_utils:isa(who, $player) && raise(E_INVARG);
!$object_utils:has_property(this, log + "_log") && raise(E_INVARG);
audience = this:get_log_audience(log);
return audience == 1 || (audience == 2 && $object_utils:isa(who, $builder)) || (audience == 3 && who.programmer) || (audience == 4 && who.wizard);
"Last modified Mon Mar 12 04:44:52 2018 CDT by Jason Perino (#91@ThetaCore).";
