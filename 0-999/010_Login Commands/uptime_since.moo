#10:uptime_since   this none this rxd

"uptime_since(time): How much time the MOO has been up since `time'";
since = args[1];
up = time() - since;
for x in (this.downtimes)
  if (x[1] < since)
    "downtime predates when we're asking about";
    return up;
  endif
  "since the server was down between x[2] and x[1], don't count it as uptime";
  up = up - (x[1] - max(x[2], since));
endfor
return up;
