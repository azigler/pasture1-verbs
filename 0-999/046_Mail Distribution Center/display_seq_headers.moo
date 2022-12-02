#46:display_seq_headers   this none this rxd

":display_seq_headers(msg_seq[,cur[,last_read_date]])";
"This is the default header display routine.";
"Prints a list of headers of messages on caller to player.  msg_seq is the handle returned by caller:parse_message_seq(...).  cur is the player's current message.  last_read_date is the date of the last of the already-read messages.";
set_task_perms(caller_perms());
{msg_seq, ?cur = 0, ?last_old = $maxint} = args;
keep_seq = {@$seq_utils:contract(caller:kept_msg_seq(), $seq_utils:complement(msg_seq, 1, caller:length_all_msgs())), $maxint};
k = 1;
mcount = 0;
width = player:linelen() || 79;
for x in (msgs = caller:messages_in_seq(msg_seq))
  if (keep_seq[k] <= (mcount = mcount + 1))
    k = k + 1;
  endif
  annot = (d = x[2][1]) > last_old ? "+" | (k % 2 ? " " | "=");
  line = tostr($string_utils:right(x[1], 4, cur == x[1] ? ">" | " "), ":", annot, " ", caller:msg_summary_line(@x[2]));
  player:tell(line[1..min(width, $)]);
  if (ticks_left() < 500 || seconds_left() < 2)
    suspend(0);
  endif
endfor
player:tell("----+");
