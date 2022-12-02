#40:confunc   this none this rxd

if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this) && caller != #0)
  return E_PERM;
endif
this:check_mail();
this:mail_catch_up();
this:check_mail_lists();
pass(@args);
