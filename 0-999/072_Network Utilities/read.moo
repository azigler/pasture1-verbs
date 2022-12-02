#72:read   this none this rxd

"for trusted players, they can read from objects they own or open connections";
if (!this:trust(caller_perms()))
  return E_PERM;
elseif (valid(x = args[1]))
  if (x.owner == x || x.owner != caller_perms())
    return E_INVARG;
  endif
  "elseif (!this:is_outgoing_connection(x) return E_PERM";
endif
return `read(@args) ! ANY';
