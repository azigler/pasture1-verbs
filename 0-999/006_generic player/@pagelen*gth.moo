#6:@pagelen*gth   any none none rd

"@pagelength number  -- sets page buffering to that many lines (or 0 to turn off page buffering)";
if (player != this)
  "... somebody is being sneaky ...";
  "... Can't do set_task_perms(player) since we need to be `this'...";
  "... to notify and `this.owner' to change +c properties...";
  return;
elseif (!dobjstr)
  notify(player, tostr("Usage:  ", verb, " <number>"));
  notify(player, tostr("Current page length is ", player.pagelen, "."));
  return;
elseif (0 > (newlen = toint(dobjstr)))
  notify(player, "Page length can't be a negative number.");
  return;
elseif (newlen == 0)
  player.pagelen = 0;
  notify(player, "Page buffering off.");
  if (lb = this.linebuffer)
    "queued text remains";
    this:notify_lines(lb);
    clear_property(this, "linebuffer");
  endif
elseif (newlen < 5)
  player.pagelen = 5;
  notify(player, "Too small.  Setting it to 5.");
else
  notify(player, tostr("Page length is now ", player.pagelen = newlen, "."));
endif
if (this.linebuffer)
  notify(this, strsub(this.more_msg, "%n", tostr(length(this.linebuffer))));
  player.linetask = {task_id(), task_id()};
  player.linesleft = 0;
else
  player.linetask = {0, task_id()};
  player.linesleft = player.pagelen - 2;
endif
