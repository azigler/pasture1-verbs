#29:"display_seq_headers display_seq_full"   this none this rxd

":display_seq_headers(msg_seq[,cur])";
":display_seq_full(msg_seq[,cur]) => {cur}";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
{msg_seq, ?cur = 0, ?read_date = $maxint} = args;
last = ldate = 0;
player:tell("       WHEN           ", $string_utils:left(this.keyword, -30), "BY");
for x in (msgs = this:messages_in_seq(args[1]))
  msgnum = $string_utils:right(last = x[1], 4, cur == x[1] ? ">" | " ");
  ldate = x[2][1];
  if (typeof(x[2][2]) != OBJ)
    hdr = this:msg_summary_line(@x[2]);
  else
    if (ldate < time() - 31536000)
      c = player:ctime(ldate);
      date = c[5..11] + c[21..25];
    else
      date = player:ctime(ldate)[5..16];
    endif
    hdr = tostr(ctime(ldate)[5..16], "   ", $string_utils:left(tostr(x[2][4], " (", x[2][3], ")"), 30), valid(w = x[2][2]) ? w.name | "??", " (", x[2][2], ")");
  endif
  player:tell(msgnum, ldate > read_date ? ":+ " | ":  ", hdr);
  $command_utils:suspend_if_needed(0);
endfor
if (verb == "display_seq_full")
  return {last, ldate};
else
  player:tell("----+");
endif
