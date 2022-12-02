#6:@version   any none none rd

if (args && argstr == "config")
  commit = url = branch = "unknown";
  for x in (server_version("source"))
    if (x[1] == "commit")
      commit = x[2];
    elseif (x[1] == "url")
      url = x[2];
    elseif (x[1] == "branch")
      branch = x[2];
    endif
  endfor
  player:tell("Exhaustive build configuration for ", $server["name"], " ", server_version(), " (commit ", commit, " on the '", branch, "' branch from ", url, ")");
  player:tell();
  options = server_version("options");
  "Autofit is stupid, so we need to tostr everything:";
  for x in [1..length(options)]
    if (options[x][2] == #-1)
      options[x][2] = "OFF";
    elseif (typeof(options[x][2]) == LIST)
      options[x][2] = tostr("ON (value ", options[x][2][1], ")");
    else
      options[x][2] = tostr(options[x][2]);
    endif
  endfor
  player:tell_lines($string_utils:autofit(options));
else
  if ($object_utils:has_property($local, "server_hardware"))
    hw = " on " + $local.server_hardware + ".";
  else
    hw = ".";
  endif
  server_version = server_version();
  if (server_version[1] == "v")
    server_version[1..1] = "";
  endif
  player:tell($network.moo_name, " is currently running version ", server_version, " of the ", $server["name"], " server code", hw);
  try
    {MOOname, sversion, coretime} = $server["core_history"][1];
    player:tell("The database was derived from a core created on ", $time_utils:time_sub("$n $t, $Y", coretime), " at ", MOOname, " for version ", sversion, " of the server.");
  except (E_RANGE)
    player:tell("The database was created from scratch.");
  except (ANY)
    player:tell("No information is available on the database version.");
  endtry
  player:tell("To display additional build configuration, use `@version config'.");
endif
"Last modified Fri Dec  2 23:15:09 2022 UTC by Saeed (#128).";
