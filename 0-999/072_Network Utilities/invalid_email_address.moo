#72:invalid_email_address   this none this rxd

"invalid_email_address(email) -- check to see if email looks like a valid email address. Return reason why not.";
address = args[1];
if (!address)
  return "no email address supplied";
endif
if (!(at = rindex(address, "@")))
  return "'" + address + "' doesn't look like a valid internet email address";
endif
name = address[1..at - 1];
host = address[at + 1..$];
if (match(name, "^in%%") || match(name, "^smtp%%"))
  return tostr("'", name, "' doesn't look like a valid username (try removing the 'in%' or 'smtp%')");
endif
if (!match(host, $network.valid_host_regexp))
  return tostr("'", host, "' doesn't look like a valid internet host");
endif
if (!match(name, $network.valid_email_regexp))
  return tostr("'", name, "' doesn't look like a valid user name for internet mail");
endif
return "";
