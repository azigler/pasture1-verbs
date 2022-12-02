#24:expire_mail_lists   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
sum = 0;
for x in ($object_utils:leaves_suspended($mail_recipient))
  this.expiration_progress = x;
  temp = x:expire_old_messages();
  if (typeof(temp) == INT)
    sum = sum + temp;
  endif
  "just suspend for every fucker, I'm tired of losing.";
  set_task_perms($wiz_utils:random_wizard());
  suspend(0);
endfor
$mail_agent:send_message(player, this.expiration_recipient, verb, tostr(sum, " messages have been expired from mailing lists."));
return sum;
