#63:show*-history   this none none rxd

if ($perm_utils:controls(valid(caller_perms()) ? caller_perms() | player, this))
  for x in (this.history)
    pname = valid(x[1]) ? x[1].name | "A recycled player";
    oname = valid(x[2]) ? x[2].name | "recycled";
    player:notify(tostr(pname, " (", x[1], ") recycled ", x[2], " (now ", oname, ")"));
  endfor
else
  player:tell("Sorry.");
endif
