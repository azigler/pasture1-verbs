#24:expire_mail_weekly   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
fork (7 * 24 * 60 * 60)
  this:(verb)();
endfork
this:expire_mail();
