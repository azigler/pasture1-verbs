#10:"v*ersion @v*ersion"   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
else
  notify(player, tostr("The MOO is currently running version ", server_version(), " of the ", $server["name"], " server code."));
  return 0;
endif
