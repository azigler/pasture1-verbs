#132:set_log_level_for   this none this xd

":set_log_level_for([who,] log, level): Set the level of messages that who is listening to to level.";
{?who = player, log, level} = args;
!caller_perms().wizard && raise(E_PERM);
!$object_utils:isa(who, $player) && raise(E_INVARG);
!$object_utils:has_property(this, log + "_log") && raise(E_INVARG);
level < 1 || level > length(this.log_levels) + 1 && raise(E_INVARG);
l = log in $list_utils:slice(who.log_levels);
if (!l)
  who.log_levels = setadd(who.log_levels, {log, level});
else
  who.log_levels[l][2] = level;
endif
"Last modified Mon Mar 12 04:43:35 2018 CDT by Jason Perino (#91@ThetaCore).";
