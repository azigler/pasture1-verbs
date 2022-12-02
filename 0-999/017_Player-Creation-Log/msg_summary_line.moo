#17:msg_summary_line   this none this rxd

when = ctime(args[1])[5..10];
from = args[2];
by = $string_utils:left(from[1..index(from, " (") - 1], -9);
subject = args[4];
who = subject[1..(open = index(subject, " (")) - 1];
if ((close = rindex(subject, ")")) > open)
  who = who[1..min(9, $)] + subject[open..close];
endif
who = $string_utils:left(who, 18);
line = args[("" in args) + 1];
email = line[1..index(line + " ", " ") - 1];
if (!index(email, "@"))
  email = "??";
endif
return tostr(when, "  ", by, " ", who, "  ", email);
