#24:expire_mail   none none none rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
this:expire_mail_lists();
this:expire_mail_players();
