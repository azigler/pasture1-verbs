#14:receive_message   this none this rxd

if (!this:is_writable_by(caller_perms()))
  return E_PERM;
else
  this.messages = this._mgr:insert_last(this.messages, msg = this:_makemsg(new = this:new_message_num(), args[1]));
  this.last_msg_date = this:_message_date(@msg);
  this.last_used_time = time();
  return new;
endif
