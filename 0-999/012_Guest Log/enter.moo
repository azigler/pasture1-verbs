#12:enter   this none this rxd

":enter(who,islogin,time,site)";
"adds an entry to the connection log for a given guest (caller).";
if ($object_utils:isa(caller, $guest))
  $guest_log.connections = {{caller, @args}, @$guest_log.connections[1..min($guest_log.max_entries, $)]};
else
  return E_PERM;
endif
