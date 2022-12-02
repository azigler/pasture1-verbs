#46:display_seq_full   this none this rxd

":display_seq_full(msg_seq[,preamble]) => {cur, last-read-date}";
"This is the default message display routine.";
"Prints entire messages on folder (caller) to player.  msg_seq is the handle returned by :parse_message_seq(...) and indicates which messages should be printed.  preamble, if given will precede the output of the message itself, in which case the message number will be substituted for \"%d\".  Returns the number of the final message in the sequence (which can be then used as the new current message number).";
set_task_perms(caller_perms());
{msg_seq, ?preamble = ""} = args;
cur = date = 0;
for x in (msgs = caller:messages_in_seq(msg_seq))
  cur = x[1];
  date = x[2][1];
  player:display_message(preamble ? strsub(preamble, "%d", tostr(cur)) | {}, caller:msg_full_text(@x[2]));
  if (ticks_left() < 500 || seconds_left() < 2)
    suspend(0);
  endif
endfor
return {cur, date};
