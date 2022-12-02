#95:value   this none this rxd

if (!(e = this:readable(who = args ? args[1] | player in this.active) || this:ok(who)))
  return e;
endif
vlist = this:to_value(@this:text(who));
if (vlist[1])
  player:tell("Error on line ", vlist[1], ":  ", vlist[2]);
  return E_INVARG;
else
  return vlist[2];
endif
