#24:set_programmer   this none this rxd

":set_programmer(victim[,mail from])  => 1 or error.";
"Sets victim.programmer, chparents victim to $prog if necessary, and sends mail to $new_prog_log, mail is from optional second arg or caller_perms().";
whodunnit = caller_perms();
{victim, ?mailfrom = whodunnit} = args;
if (!whodunnit.wizard)
  return E_PERM;
elseif (!(valid(victim) && (is_player(victim) && $object_utils:isa(victim, $player))))
  return E_INVARG;
elseif (victim.programmer)
  return E_NONE;
elseif (this:check_prog_restricted(victim))
  return E_INVARG;
elseif (typeof(e = `victim.programmer = 1 ! ANY') == ERR)
  return e;
else
  $quota_utils:adjust_quota_for_programmer(victim);
  if (!$object_utils:isa(victim, $prog))
    if (typeof(e = `chparent(victim, $prog) ! ANY') == ERR)
      "...this isn't really supposed to happen but it could...";
      player:notify(tostr("chparent(", victim, ",", $prog, ") failed:  ", e));
      player:notify("Check for common properties.");
    endif
  else
    player:notify(tostr(victim.name, " was already a child of ", parent(victim).name, " (", parent(victim), ")"));
  endif
  if (!$mail_agent:send_message(mailfrom, {$new_prog_log, victim}, tostr("@programmer ", victim.name, " (", victim, ")"), tostr("I just gave ", victim.name, " a programmer bit."))[1])
    $mail_agent:send_message(mailfrom, {$new_prog_log}, tostr("@programmer ", victim.name, " (", victim, ")"), tostr("I just gave ", victim.name, " a programmer bit."));
  endif
  return 1;
endif
