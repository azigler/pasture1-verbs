#40:mail_option   this none this rxd

":mail_option(name)";
"Returns the value of the specified mail option";
if (caller in {this, $mail_editor, $mail_agent} || $perm_utils:controls(caller_perms(), this))
  return $options["mail"]:get(this.mail_options, args[1]);
else
  return E_PERM;
endif
