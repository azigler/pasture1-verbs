#43:seconds_until_date   this none this rx

"Copied from Ballroom Complex (#29992):from_date by Keelah! (#30246) Tue Jul 13 19:42:32 1993 PDT";
":seconds_until_date(month,day,time,which)";
"month is a string or the numeric representation of the month, day is a number, time is a string in the following format, hh:mm:ss.";
"which==-1 => use most recent such month.";
"which==+1 => use first upcoming such month.";
"which==0 => use closest such month.";
"This will return the number of seconds until the month, day and time given to it.";
"Written by Keelah, on July 5, 1993.";
{month, day, time, which} = args;
converted = 0;
converted = converted + $time_utils:from_month(month, which, day);
current = this:seconds_until_time("12:00:00");
get_seconds = this:seconds_until_time(time);
if (get_seconds < 0)
  get_seconds = get_seconds + 39600 - current;
else
  get_seconds = get_seconds + 39600 - current;
endif
converted = converted + get_seconds - time();
return converted;
