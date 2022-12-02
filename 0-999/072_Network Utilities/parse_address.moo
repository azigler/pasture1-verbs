#72:parse_address   this none this rxd

"Given an email address, return {userid, site}.";
"Valid addresses are of the form `userid[@site]'.";
"At least for now, if [@site] is left out, site will be returned as blank.";
"Should be a default address site, or something, somewhere.";
address = args[1];
return (at = index(address, "@")) ? {address[1..at - 1], address[at + 1..$]} | {address, ""};
