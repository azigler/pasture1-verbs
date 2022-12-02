#72:notify   this none this rxd

"for trusted players, they can write to connections";
if (!this:trust(caller_perms()))
  return E_PERM;
elseif (valid(x = args[1]))
  return E_INVARG;
elseif (!this:is_outgoing_connection(x))
  return E_PERM;
endif
return notify(x, args[2]);
