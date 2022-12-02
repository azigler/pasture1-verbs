#46:msg_summary_line   this none this rxd

":msg_summary_line(@msg) => date/from/subject as a single string.";
body = ("" in {@args, ""}) + 1;
if (body > length(args) || !(subject = args[body]))
  subject = "(None.)";
endif
if (args[1] < time() - 31536000)
  c = player:ctime(args[1]);
  date = c[5..11] + c[21..25];
else
  date = player:ctime(args[1])[5..16];
endif
from = args[2];
if (args[4] != " ")
  subject = args[4];
endif
return tostr(date, "   ", $string_utils:left(from, 20), "   ", subject);
