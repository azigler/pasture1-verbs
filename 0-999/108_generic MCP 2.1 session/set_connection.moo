#108:set_connection   this none this rx

if (caller == this || $perm_utils:controls(caller_perms(), this))
  this.connection = args[1];
  this:set_name("session for " + tostr(this.connection));
  return 1;
else
  return E_PERM;
endif
