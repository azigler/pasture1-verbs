#6:@version   none none none rd

if ($object_utils:has_property($local, "server_hardware"))
  hw = " on " + $local.server_hardware + ".";
else
  hw = ".";
endif
server_version = server_version();
if (server_version[1] == "v")
  server_version[1..1] = "";
endif
player:notify(tostr("The MOO is currently running version ", server_version, " of the ", $server["name"], " server code", hw));
try
  {MOOname, sversion, coretime} = $server["core_history"][1];
  player:notify(tostr("The database was derived from a core created on ", $time_utils:time_sub("$n $t, $Y", coretime), " at ", MOOname, " for version ", sversion, " of the server."));
except (E_RANGE)
  player:notify("The database was created from scratch.");
except (ANY)
  player:notify("No information is available on the database version.");
endtry
