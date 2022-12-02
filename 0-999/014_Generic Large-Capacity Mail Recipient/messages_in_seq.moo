#14:messages_in_seq   this none this rxd

if (!this:ok(caller, caller_perms()))
  return E_PERM;
elseif (typeof(seq = args[1]) != LIST)
  x = this._mgr:find_nth(this.messages, seq);
  return {this:_message_num(@x), this:_message_text(@x)};
else
  msgs = {};
  while (seq)
    handle = this._mgr:start(this.messages, seq[1], seq[2] - 1);
    while (handle)
      for x in (handle[1])
        msgs = {@msgs, {this:_message_num(@x), this:_message_text(@x)}};
      endfor
      handle = this._mgr:next(@listdelete(handle, 1));
      $command_utils:suspend_if_needed(0);
    endwhile
    seq = seq[3..$];
  endwhile
  return msgs;
endif
