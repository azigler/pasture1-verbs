#31:connection_name_hash   this none this rxd

"Compute an encrypted hash of the guest's (last) connection, using 'crypt'. Basically, you can't tell where the guest came from, but it is unlikely that two guests will have the same hash";
"You can use guest:connection_name_hash(seed) as a string to identify whether two guests are from the same place.";
hash = toint(caller_perms());
host = $string_utils:connection_hostname(this.last_connect_place);
for i in [1..length(host)]
  hash = hash * 14 + index($string_utils.ascii, host[i]);
endfor
return crypt(tostr(hash), @args);
