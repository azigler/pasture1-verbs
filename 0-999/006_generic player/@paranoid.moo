#6:@paranoid   any any any rd

if (args == {} || (typ = args[1]) == "")
  $paranoid_db:set_kept_lines(this, 10);
  this.paranoid = 1;
  this:notify("Anti-spoofer on and keeping 10 lines.");
elseif (index("immediate", typ))
  $paranoid_db:set_kept_lines(this, 0);
  this.paranoid = 2;
  this:notify("Anti-spoofer now in immediate mode.");
elseif (index("off", typ) || typ == "0")
  this.paranoid = 0;
  $paranoid_db:set_kept_lines(this, 0);
  this:notify("Anti-spoofer off.");
elseif (tostr(y = toint(typ)) != typ || y < 0)
  this:notify(tostr("Usage: ", verb, " <lines to be kept>     to turn on your anti-spoofer."));
  this:notify(tostr("       ", verb, " off                    to turn it off."));
  this:notify(tostr("       ", verb, " immediate              to use immediate mode."));
else
  this.paranoid = 1;
  kept = $paranoid_db:set_kept_lines(this, y);
  this:notify(tostr("Anti-spoofer on and keeping ", kept, " lines."));
endif
