#45:receive_message   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
else
  this.messages = {@this.messages, {new = this:new_message_num(), args[1]}};
  this.last_msg_date = args[1][1];
  this.last_used_time = time();
  return new;
endif
