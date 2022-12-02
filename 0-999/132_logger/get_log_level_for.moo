#132:get_log_level_for   this none this xd

":get_log_level_for([who,] log): Get the level of messages that who is listening to.";
{?who = player, log} = args;
!caller_perms().wizard && raise(E_PERM);
!$object_utils:isa(who, $player) && raise(E_INVARG);
!$object_utils:has_property(this, log + "_log") && raise(E_INVARG);
return `who.log_levels[log in $list_utils:slice(who.log_levels)][2] ! E_RANGE => this.default_log_level';
"Last modified Mon Mar 12 04:27:57 2018 CDT by Jason Perino (#91@ThetaCore).";
