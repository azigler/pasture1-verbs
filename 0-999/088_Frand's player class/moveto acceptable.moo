#88:"moveto acceptable"   this none this rxd

"'moveto (<destination>)', 'accept (<object>)' - Check whether this :moveto or :accept is allowed or refused. If it is allowed, do it. This code is slightly modified from an original verb by Grump.  Upgraded by Bits to account for forthcoming 1.8.0 behavior of callers().";
by = callers();
"Ignore all the verbs on this.";
while ((y = by[1])[1] == this && y[2] == verb)
  by = listdelete(by, 1);
endwhile
act = verb == "moveto" ? "move" | "accept";
if (player != this && this:refuses_action(player, act, args[1]))
  "check player";
  return 0;
endif
last = #-1;
for k in (by)
  if ((perms = k[3]) == #-1 && k[2] != "" && k[1] == #-1)
  elseif (!perms.wizard && perms != this)
    if (perms != last)
      "check for possible malicious programmer";
      if (this:refuses_action(perms, act, args[1]))
        return 0;
      endif
      last = perms;
    endif
  endif
endfor
"Coded added 11/8/98 by TheCat, to refuse spurned objects.";
if (act == "accept" && typeof(this.spurned_objects) == LIST)
  for item in (this.spurned_objects)
    if ($object_utils:isa(args[1], item))
      return 0;
    endif
  endfor
endif
"(end of code added by TheCat)";
pass(@args);
