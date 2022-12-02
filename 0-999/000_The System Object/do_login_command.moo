#0:do_login_command   this none this rxd

"...This code should only be run as a server task...";
if (callers())
  return E_PERM;
endif
"...perform a threaded DNS name lookup and store the result for the duration of the connection...";
$login:connection_name_lookup(player);
if (typeof(h = $network:incoming_connection(player)) == OBJ)
  "connected to an object";
  $login:delete_name_lookup(player);
  switch_player(player, h);
  return;
elseif (h)
  return 0;
endif
host = $string_utils:connection_hostname(player);
if ($login:redlisted(host))
  boot_player(player);
  server_log(tostr("REDLISTED: ", player, " from ", host));
  return 0;
endif
"HTTP server by Krate";
try
  newargs = $http:handle_connection(@args);
  if (!newargs)
    return 0;
  endif
  args = newargs;
except v (ANY)
endtry
"...checks to see if the login is spamming the server with too many commands...";
if (!$login:maybe_limit_commands())
  args = $login:parse_command(@args);
  retval = $login:(args[1])(@listdelete(args, 1));
  if (typeof(retval) == OBJ)
    $login:delete_name_lookup(player);
    switch_player(player, retval);
    return;
  else
    return retval;
  endif
endif
