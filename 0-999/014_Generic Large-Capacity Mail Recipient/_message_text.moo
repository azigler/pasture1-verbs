#14:_message_text   this none this rxd

if (caller == this || this:is_readable_by(caller_perms()))
  "perms check added HTC 16 Feb 1999";
  return {@args[3..$], @args[1] ? {"", @this.(args[1])} | {}};
else
  return E_PERM;
endif
