#4:build_option   this none this rxd

":build_option(name)";
"Returns the value of the specified builder option";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  return $options["build"]:get(this.build_options, args[1]);
else
  return E_PERM;
endif
