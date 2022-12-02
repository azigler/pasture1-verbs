#6:@wrap   none any none rd

if (player != this)
  "... someone is being sneaky...";
  "... Can't do set_task_perms(player) since we need to be `this'...";
  "... to notify and `this.owner' to change +c properties...";
  return;
endif
linelen = player.linelen;
if (!(prepstr in {"on", "off"}))
  player:notify("Usage:  @wrap on|off");
  player:notify(tostr("Word wrap is currently ", linelen > 0 ? "on" | "off", "."));
  return;
endif
player.linelen = abs(linelen) * (prepstr == "on" ? 1 | -1);
player:notify(tostr("Word wrap is now ", prepstr, "."));
