#10:connection_name_lookup   this none this rxd

":connection_name_lookup(connection)";
"Perform a threaded DNS lookup on 'connection' and record it to avoid multiple calls.";
if (caller != #0 && caller != this)
  return E_PERM;
endif
{connection} = args;
if (!(connection in this.name_lookup_players))
  this.name_lookup_players = setadd(this.name_lookup_players, connection);
  connection_name_lookup(connection, 1);
endif
