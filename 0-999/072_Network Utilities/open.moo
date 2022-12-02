#72:open   this none this rxd

":open(address, port, [connect-connection-to])";
"Open a network connection to address/port.  If the connect-connection-to is passed, then the connection will be connected to that object when $login gets ahold of it.  If not, then the connection is just ignored by $login, i.e. not bothered by it with $welcome_message etc.";
"The object specified by connect-connection-to has to be a player (though it need not be a $player).";
"Returns the (initial) connection or an error, as in open_network_connection";
if (!this:trust(caller_perms()))
  return E_PERM;
endif
{address, port, ?connect_to} = args;
if (length(args) < 3)
  connect_to = $nothing;
elseif (typeof(connect_to) == OBJ && valid(connect_to) && is_player(connect_to))
  if (!$perm_utils:controls(caller_perms(), connect_to))
    return E_PERM;
  endif
else
  return E_INVARG;
endif
if (typeof(connection = `open_network_connection(address, port) ! ANY') != ERR)
  if (valid(connect_to))
    this.connect_connections_to = {@this.connect_connections_to, {connection, connect_to}};
  endif
endif
return connection;
