#6:@linelen*gth   any none none rd

if (callers() ? caller != this && !$perm_utils:controls(caller_perms(), this) | player != this)
  "... somebody is being sneaky ...";
  return;
endif
curlen = player.linelen;
wrap = curlen > 0;
wrapstr = wrap ? "on" | "off";
if (!dobjstr)
  player:notify(tostr("Usage:  ", verb, " <number>"));
  player:notify(tostr("Current line length is ", abs(curlen), ".  Word wrapping is ", wrapstr, "."));
  return;
endif
newlen = toint(dobjstr);
if (newlen < 0)
  player:notify("Line length can't be a negative number.");
  return;
elseif (newlen == 0)
  return player:notify("Linelength zero makes no sense.  You want to use '@wrap off' if you want to turn off wrapping.");
elseif (newlen < 10)
  player:notify("You don't want your linelength that small.  Setting it to 10.");
  newlen = 10;
elseif (newlen > 1000)
  player:notify("You don't want your line length that large.  Setting it to 1000.");
  newlen = 1000;
endif
this:set_linelength(newlen);
player:notify(tostr("Line length is now ", abs(player.linelen), ".  Word wrapping is ", wrapstr, "."));
if (!wrap)
  player:notify("To enable word wrapping, type `@wrap on'.");
endif
