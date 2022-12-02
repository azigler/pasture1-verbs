#7:announce_msg   this none this rxd

":announce_msg(place, what, msg)";
"  announce msg in place (except to what). Prepend with what:title if it isn't part of the string";
msg = args[3];
what = args[2];
title = what:titlec();
if (!$string_utils:index_delimited(msg, title))
  msg = tostr(title, " ", msg);
endif
args[1]:announce_all_but({what}, msg);
