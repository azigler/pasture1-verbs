#24:"check_player_request check_reregistration"   this none this rxd

":check_player_request(name [,email [,connection]])";
" check if the request for player and email address is valid;";
" return empty string if it valid, or else a string saying why not.";
" The result starts with - if this is a 'send email, don't try again' situation.";
":check_reregistration(who, email, connection)";
"  Since name is ignored, only check the 'email' parts and use the first arg";
"  for the re-registering player.";
if (!caller_perms().wizard)
  return E_PERM;
  "accesses registration information -- wiz only";
endif
name = args[1];
if (verb == "check_reregistration")
  "don't check player name";
elseif (!name)
  return "A blank name isn't allowed.";
elseif (name == "<>")
  return "Names with angle brackets aren't allowed.";
elseif (index(name, " "))
  return "Names with spaces are not allowed. Use dashes or underscores.";
elseif (match(name, "^<.*>$"))
  return tostr("Try using ", name[2..$ - 1], " instead of ", name, ".");
elseif ($player_db.frozen)
  return "New players cannot be created at the moment, try again later.";
elseif (!$player_db:available(name))
  return "The name '" + name + "' is not available.";
elseif ($login:_match_player(name) != $failed_match)
  return "The name '" + name + "' doesn't seem to be available.";
endif
if (length(args) == 1)
  "no email address supplied.";
  return "";
endif
address = args[2];
addrargs = verb == "check_reregistration" ? {name} | {};
if ($registration_db:suspicious_address(address, @addrargs))
  return "-There has already been a character with that or a similar email address.";
endif
if (reason = $network:invalid_email_address(address))
  return reason + ".";
endif
parsed = $network:parse_address(address);
if ($registration_db:suspicious_userid(parsed[1]))
  return tostr("-Automatic registration from an account named ", parsed[1], " is not allowed.");
endif
connection = length(args) > 2 ? args[3] | parsed[2];
check_connection = $wiz_utils.registration_domain_restricted && verb == "check_player_request";
if (connection[max($ - 2, 1)..$] == ".uk" && parsed[2][1..3] == "uk.")
  return tostr("Addresses must be in internet form. Try ", parsed[1], "@", $string_utils:from_list($list_utils:reverse($string_utils:explode(parsed[2], ".")), "."), ".");
elseif (check_connection && match(connection, "^[0-9.]+$"))
  "Allow reregistration from various things we wouldn't allow registration from.  Let them register to their yahoo acct...";
  return "-The system cannot resolve the name of the system you're connected from.";
elseif (check_connection && (a = $network:local_domain(connection)) != (b = $network:local_domain(parsed[2])))
  return tostr("-The connection is from '", a, "' but the mail address is '", b, "'; these don't seem to be the same place.");
elseif (verb == "check_player_request" && $login:spooflisted(parsed[2]))
  return tostr("-Automatic registration is not allowed from ", parsed[2], ".");
endif
return "";
