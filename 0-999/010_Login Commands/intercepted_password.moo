#10:intercepted_password   this none this rxd

caller == #0 || raise(E_PERM);
this:delete_interception(player);
set_connection_option(player, "client-echo", 1);
notify(player, "");
try
  {candidate, ?password = ""} = args;
except (E_ARGS)
  return 0;
endtry
return this:connect(tostr(candidate), password);
