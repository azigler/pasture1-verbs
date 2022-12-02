#72:error   this none this rxd

":error(ERN, host, port) interpret open_network_connection(host, port) error";
{msg, host, port} = args;
if (msg == E_PERM)
  return "Networking not enabled in server, or else user doesn't have permission to call o_n_c();";
elseif (msg == E_INVARG)
  return tostr("The host/port ", toliteral(host), "/", toliteral(port), " is invalid or is not responding.");
elseif (msg == E_QUOTA)
  return tostr("The connection to ", toliteral(host), "/", toliteral(port), " cannot be made at this time.");
else
  return tostr("Unusual error: ", toliteral(msg));
endif
