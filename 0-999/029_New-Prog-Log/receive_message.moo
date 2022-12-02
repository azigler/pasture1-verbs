#29:receive_message   this none this rxd

if (!this:is_writable_by(caller_perms()))
  return E_PERM;
else
  if (msgs = this.messages)
    new = msgs[$][1] + 1;
  else
    new = 1;
  endif
  if (rmsgs = this.messages_going)
    lbrm = rmsgs[$][2];
    new = max(new, lbrm[$][1] + 1);
  endif
  m = args[1];
  if (index(m[4], "@programmer ") == 1)
    m = {m[1], toobj(args[2]), o = $mail_agent:parse_address_field(m[4])[1], o.name};
  endif
  this.messages = {@msgs, {new, m}};
  this.last_msg_date = m[1];
  this.last_used_time = time();
  return new;
endif
