#43:to_seconds   this none this rxd

"Given string hh:mm:ss ($string_utils:explode(ctime(time))[4]), this returns";
"the number of seconds elapsed since 00:00:00.  I can't remember why I";
"created this verb, but I'm sure it serves some useful purpose.";
return 60 * 60 * toint(args[1][1..2]) + 60 * toint(args[1][4..5]) + toint(args[1][7..8]);
