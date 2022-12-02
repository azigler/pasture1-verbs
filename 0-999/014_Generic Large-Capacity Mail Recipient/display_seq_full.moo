#14:display_seq_full   this none this rxd

":display_seq_full(msg_seq[,preamble]) => {cur}";
"This is the default message display routine.";
"Prints the indicated messages on folder to player.  msg_seq is the handle returned by folder:parse_message_seq(...).  Returns the number of the final message in the sequence (to be the new current message number).";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
{seq, ?preamble = ""} = args;
cur = date = 0;
while (seq)
  handle = this._mgr:start(this.messages, seq[1], seq[2] - 1);
  while (handle)
    for x in (handle[1])
      cur = this:_message_num(@x);
      date = this:_message_date(@x);
      player:display_message(preamble ? strsub(preamble, "%d", tostr(cur)) | {}, this:msg_full_text(@this:_message_text(@x)));
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
    $command_utils:suspend_if_needed(0);
  endwhile
  seq = seq[3..$];
endwhile
return {cur, date};
