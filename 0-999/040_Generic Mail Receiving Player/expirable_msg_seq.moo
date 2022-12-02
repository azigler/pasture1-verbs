#40:expirable_msg_seq   this none this rxd

"Return a sequence indicating the expirable messages for this player.";
set_task_perms(caller_perms());
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (!(curmsg = this:get_current_message(this)))
  "No messages!  Don't even try.";
  return {};
elseif (0 >= (period = this:mail_option("expire") || $mail_agent.player_expire_time))
  "...no expiration allowed here...";
  return {};
else
  return $seq_utils:remove(this:unkept_msg_seq(), 1 + this:length_date_le(min(time() - period, curmsg[2] - 86400)));
  "... the 86400 is pure fudge...";
endif
