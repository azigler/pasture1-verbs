#6:display_option   this none this rxd

":display_option(name) => returns the value of the specified @display option";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  return $options["display"]:get(this.display_options, args[1]);
else
  return E_PERM;
endif
