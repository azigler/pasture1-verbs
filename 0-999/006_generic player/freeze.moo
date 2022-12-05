#6:freeze   this none this rxd

{?period = 0, ?silent = 0, ?message = "You cannot seem to do anything."} = args;
now = ftime();
period = tofloat(period);
lasttime = this.roundtime;
answer = lasttime - now;
if (answer >= 0.0)
  this:tell(silent == 1 ? message | $time_utils:english_time(toint(round(answer))) + " roundtime.");
  return false;
else
  this:tell(silent == 0 && $time_utils:english_time(toint(round(period))) + " roundtime.");
  this.roundtime = now + period;
  return true;
endif
"Last modified Mon Dec  5 19:49:33 2022 UTC by caranov (#133).";
