#45:__fix   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
msgs = {};
i = 1;
for m in (oldmsgs = this.messages)
  msgs = {@msgs, {m[1], $mail_agent:__convert_new(@m[2])}};
  if ($command_utils:running_out_of_time())
    player:notify(tostr("...", i, " ", this));
    suspend(0);
    if (oldmsgs != this.messages)
      return 0;
    endif
  endif
  i = i + 1;
endfor
this.messages = msgs;
return 1;
