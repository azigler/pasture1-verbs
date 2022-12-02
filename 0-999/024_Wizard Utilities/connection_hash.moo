#24:connection_hash   this none this rxd

"connection_hash(forwhom, host [,seed])";
"Compute an encrypted hash of the host for 'forwhom', using 'crypt'.";
{forwhom, host, @seed} = args;
hash = toint(forwhom);
for i in [1..length(host)]
  hash = hash * 14 + index($string_utils.ascii, host[i]);
endfor
return crypt(tostr(hash), @seed);
