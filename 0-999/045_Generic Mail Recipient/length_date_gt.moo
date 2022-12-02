#45:length_date_gt   this none this rxd

":length_date_le(date) => number of messages in folder dated > date";
"";
if (this:ok(caller, caller_perms()))
  date = args[1];
  return this.last_msg_date <= date ? 0 | $mail_agent:(verb)(date);
else
  return E_PERM;
endif
