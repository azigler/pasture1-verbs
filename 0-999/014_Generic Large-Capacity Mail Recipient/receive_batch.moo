#14:receive_batch   this none this rxd

if (!this:is_writable_by(caller_perms()))
  return E_PERM;
else
  new = this:new_message_num();
  msgtree = this.messages;
  for m in (args)
    msgtree = this._mgr:insert_last(msgtree, this:_makemsg(new, m[2]));
    new = new + 1;
    if ($command_utils:running_out_of_time())
      this.messages = msgtree;
      player:tell("... ", new);
      suspend(0);
      msgtree = this.messages;
      new = this:new_message_num();
    endif
  endfor
  this.messages = msgtree;
  this.last_used_time = time();
  return 1;
endif
