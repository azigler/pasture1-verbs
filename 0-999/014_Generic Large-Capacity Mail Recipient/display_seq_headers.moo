#14:display_seq_headers   this none this rxd

":display_seq_headers(msg_seq[,cur[,last_read_date]])";
"This is the default header display routine.";
"Prints a list of headers of messages on this to player.  msg_seq is the handle returned by this:parse_message_seq(...).  cur is the player's current message.  last_read_date is the date of the last of the already-read messages.";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
getmsg = this.summary_uses_body ? "_message_text" | "_message_hdr";
{seq, ?cur = 0, ?last_old = $maxint} = args;
keep_seq = {@$seq_utils:contract(this:kept_msg_seq(), $seq_utils:complement(seq, 1, this:length_all_msgs())), $maxint};
k = 1;
mcount = 0;
width = player:linelen();
while (seq)
  handle = this._mgr:start(this.messages, seq[1], seq[2] - 1);
  while (handle)
    for x in (handle[1])
      $command_utils:suspend_if_needed(0);
      if (keep_seq[k] <= (mcount = mcount + 1))
        k = k + 1;
      endif
      annot = x[3] > last_old ? "+" | (k % 2 ? " " | "=");
      line = tostr($string_utils:right(x[2], 5, cur == x[2] ? ">" | " "), ":", annot, " ", this:msg_summary_line(@this:(getmsg)(@x)));
      player:tell(line[1..min(width, $)]);
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
  endwhile
  seq = seq[3..$];
endwhile
player:tell("-----+");
