#43:seconds_until_time   this none this rx

"Copied from Ballroom Complex (#29992):seconds_until by Keelah! (#30246) Tue Jul 13 19:42:37 1993 PDT";
":seconds_until_time(hh:mm:ss)";
"Given the string hh:mm:ss, this returns the number of seconds until that hh:mm:ss. If the hh:mm:ss is before the current time(), the number returned is a negative, else the number is a positive.";
"Written by Keelah, on July 4, 1993.";
current = $time_utils:to_seconds(ctime()[12..19]);
time = $time_utils:to_seconds(args[1]);
return toint(time) - toint(current);
