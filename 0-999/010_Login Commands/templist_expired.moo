#10:templist_expired   this none this rxd

"check to see if duration has expired on temporary_<colorlist>. Removes entry if so, returns true if still <colorlisted>";
":(listname, hostname, start time, duration)";
{lname, hname, start, duration} = args;
if (!caller_perms().wizard)
  return E_PERM;
endif
if (this:uptime_since(start) > duration)
  this:(lname + "_remove_temp")(hname);
  return 0;
else
  return 1;
endif
