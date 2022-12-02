#58:prog_option   this none this rxd

":prog_option(name)";
"Returns the value of the specified prog option";
if (caller in {this, $mcp.simpleedit} || $perm_utils:controls(caller_perms(), this))
  return $options["prog"]:get(this.prog_options, args[1]);
else
  return E_PERM;
endif
