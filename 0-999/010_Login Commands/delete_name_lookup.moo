#10:delete_name_lookup   this none this rxd

":delete_name_lookup(connection)";
"Remove a connection from the list of connections that have already have name lookups performed on.";
if (caller != #0 && caller != this)
  return E_PERM;
endif
{connection} = args;
this.name_lookup_players = setremove(this.name_lookup_players, connection);
