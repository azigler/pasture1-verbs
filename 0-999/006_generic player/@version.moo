#6:@version   any none none rd

if ($object_utils:has_property($local, "server_hardware"))
  hw = " on " + $local.server_hardware + ".";
else
  hw = ".";
endif
player:notify(tostr("The MOO is currently running version ", server_version(), " of the LambdaMOO server code", hw));
try
  {MOOname, sversion, coretime} = $core_history[1];
  player:notify(tostr("The database was derived from a core created on ", $time_utils:time_sub("$n $t, $Y", coretime), " at ", MOOname, " for version ", sversion, " of the server."));
except (E_RANGE)
  player:notify("The database was created from scratch.");
except (ANY)
  player:notify("No information is available on the database version.");
endtry
"Last modified Fri Dec  9 18:46:56 2022 UTC by Saeed (#128).";
