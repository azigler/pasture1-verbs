#24:unset_programmer   this none this rxd

":unset_programmer(victim[,reason[,start time,duration]]) => 1 or error.";
"Resets victim.programmer, adds victim to .programmer_restricted.";
"Put into temporary list if 3rd and 4th arguments are given. Which restricts the victim for uptime duration since start time. Must give a reason, though it can be blank, in this case.";
{victim, ?reason = "", ?start = 0, ?duration = 0} = args;
if (!caller_perms().wizard)
  return E_PERM;
elseif (!valid(victim))
  return E_INVARG;
elseif (!victim.programmer && this:check_prog_restricted(victim))
  return E_NONE;
else
  victim.programmer = 0;
  if (is_player(victim) && $object_utils:isa(victim, $player))
    this.programmer_restricted = setadd(this.programmer_restricted, victim);
    if (start)
      this.programmer_restricted_temp = setadd(this.programmer_restricted_temp, {victim, start, duration});
    endif
  endif
  $mail_agent:send_message(caller_perms(), {$newt_log}, tostr("@deprogrammer ", victim.name, " (", victim, ")"), reason ? typeof(reason) == STR ? {reason} | reason | {});
  return 1;
endif
