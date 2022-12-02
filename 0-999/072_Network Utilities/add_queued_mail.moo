#72:add_queued_mail   this none this rxd

"$network:add_queued_mail( mail message )";
"  -- where `mail message' is in the same format as passed to :raw_sendmail";
if (caller == this)
  this.queued_mail = {@this.queued_mail, {time(), args}};
  if (!$code_utils:task_valid(this.queued_mail_task))
    fork fid (3600)
      this:send_queued_mail();
    endfork
    this.queued_mail_task = fid;
  endif
  return 1;
else
  return E_PERM;
endif
