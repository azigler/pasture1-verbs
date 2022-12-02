#45:expire_old_messages   this none this rxd

if (this:ok_write(caller, caller_perms()))
  if ($network.active)
    "Passed security check...";
    set_task_perms($wiz_utils:random_wizard());
    for x in (this.mail_notify)
      if (!$object_utils:has_verb(x, "notify_mail"))
        "In theory I should call this:delete_notify but it's ugly and ticky as sin and I'm lazy.";
        this.mail_notify = setremove(this.mail_notify, x);
      endif
    endfor
    if (this.expire_period && (rmseq = $seq_utils:remove(this:unkept_msg_seq(), 1 + this:length_date_le(time() - this.expire_period))))
      "... i.e., everything not marked kept that is older than expire_period";
      if (this.registered_email && this.email_validated)
        format = this.owner:format_for_netforward(this:messages_in_seq(rmseq), " expired from " + $mail_agent:name(this));
        $network:sendmail(this.registered_email, @{format[2], @format[1]});
        "Do nothing if it bounces, etc.";
      endif
      this:rm_message_seq(rmseq);
      return this:expunge_rmm();
    else
      return 0;
    endif
  endif
else
  return E_PERM;
endif
