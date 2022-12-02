#40:check_mail   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  nm = this:length_all_msgs() - this:length_date_le(this:get_current_message()[2]);
  if (nm)
    this:notify(tostr("You have new mail (", nm, " message", nm == 1 ? "" | "s", ").", this:mail_option("expert") ? "" | "  Type 'help mail' for info on reading it."));
  endif
endif
