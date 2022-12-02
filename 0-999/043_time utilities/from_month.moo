#43:from_month   this none this rxd

"from_month(month,which[,d])";
"numeric time (seconds since 1970) corresponding to midnight (PST) of the dth (first) day of the given month.  Use either the month name or a 1..12 number (1==January,...)";
"  which==-1 => use most recent such month.";
"  which==+1 => use first upcoming such month.";
"  which==0  => use closest such month.";
"larger (absolute) values for which specify a certain number of years into the future or past.";
{month, ?dir = 0, ?dth = 1} = args;
if (!(toint(month) || (month = $string_utils:find_prefix(month, this.months))))
  return E_DIV;
endif
delta = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334}[month] + dth - 1;
day = (time() - 28800) / 86400;
day = day - (day + 672) / 1461 - delta;
if (dir)
  day = day / 365 + dir + (dir <= 0);
else
  day = (2 * day + 365) / 730;
endif
day = day * 365 + delta;
day = day + (day + 671) / 1460;
return day * 86400 + 28800;
