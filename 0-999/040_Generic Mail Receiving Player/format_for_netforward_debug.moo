#40:format_for_netforward_debug   this none this rxd

"Takes a message sequence (the actual messages, not just the sequence describing it) and grovels over it filling text etc.  Returns a two valued list: {formatted message, header for same}";
set_task_perms(caller_perms());
{message_seq, folderstr} = args;
netmail = {};
linelen = this:linelen();
maxmsg = minmsg = 0;
for msg in (message_seq)
  minmsg = minmsg ? min(msg[1], minmsg) | msg[1];
  maxmsg = maxmsg ? max(msg[1], maxmsg) | msg[1];
  lines = {tostr("Message ", msg[1], folderstr, ":"), tostr("Date:     ", ctime(msg[2][1])), "From:     " + msg[2][2], "To:       " + msg[2][3], @length(subj = msg[2][4]) > 1 ? {"Subject:  " + subj} | {}};
  for line in (msg[2][5..$])
    if (typeof(line) != STR)
      "I don't know how this can happen, but apparently non-strings can end up in the mail message.  So, cope.";
      line = tostr(line);
    endif
    lines = {@lines, @$generic_editor:fill_string(line, linelen)};
    $command_utils:suspend_if_needed(0);
  endfor
  netmail = {@netmail, @lines, "", "--------------------------", "", ""};
endfor
header = tostr($network.MOO_name, " Message(s) ", minmsg, @minmsg != maxmsg ? {" - ", maxmsg} | {}, folderstr);
return {netmail, header};
