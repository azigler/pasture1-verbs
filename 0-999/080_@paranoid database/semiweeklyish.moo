#80:semiweeklyish   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  threedays = 3 * 24 * 3600;
  fork (7 * 60 * 60 + threedays - time() % threedays)
    this:(verb)();
  endfork
  this:gc();
endif
