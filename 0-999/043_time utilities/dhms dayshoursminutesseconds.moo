#43:"dhms dayshoursminutesseconds"   this none this rxd

s = args[1];
if (s < 0)
  return "-" + this:(verb)(-s);
endif
m = s / 60;
s = s % 60;
if (m)
  ss = tostr(s < 10 ? ":0" | ":", s);
  h = m / 60;
  m = m % 60;
  if (h)
    ss = tostr(m < 10 ? ":0" | ":", m, ss);
    d = h / 24;
    h = h % 24;
    return tostr(@d ? {d, h < 10 ? ":0" | ":"} | {}, h, ss);
  else
    return tostr(m, ss);
  endif
else
  return tostr(s);
endif
