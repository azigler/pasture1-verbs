#24:expire_mail_players   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
s = 0;
for p in (players())
  this.expiration_progress = p;
  if (p.owner == p && is_player(p))
    s = s + (p:expire_old_messages() || 0);
  endif
  if (ticks_left() < 10000)
    set_task_perms($wiz_utils:random_wizard());
    suspend(0);
  endif
endfor
$mail_agent:send_message(player, this.expiration_recipient, verb, tostr(s, " messages have been expired from players."));
return s;
