#61:to_text   this none this rxd

":to_text(@msg) => message in text form -- formatted like a $news entry circa October, 1993";
date = args[1];
by = args[2];
"by = by[1..index(by, \"(\") - 2]";
subject = args[4] == " " ? "-*-NEWS FLASH-*-" | $string_utils:uppercase(args[4]);
text = args[("" in {@args, ""}) + 1..$];
ctime = $time_utils:time_sub("$D, $N $3, $Y", date);
return {ctime, subject, @text};
return {subject, tostr("  by ", by, " on ", ctime), "", @text};
