#45:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  if (!(this in {$mail_recipient, $big_mail_recipient}))
    "...generic mail recipients stay in #-1...";
    move(this, $mail_agent);
    this:rm_message_seq($seq_utils:range(1, this:length_all_msgs()));
    this:expunge_rmm();
    this:_fix_last_msg_date();
    this.mail_forward = {};
    for p in ({"mail_notify", "moderator_forward", "moderator_notify", "writers", "readers", "expire_period", "last_used_time"})
      this.(p) = $mail_recipient.(p);
    endfor
  endif
endif
