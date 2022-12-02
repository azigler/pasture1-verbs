#6:edit_option   this none this rxd

":edit_option(name) => returns the value of the specified edit option";
if (caller == this || ($object_utils:isa(caller, $generic_editor) || $perm_utils:controls(caller_perms(), this)))
  return $options["edit"]:get(this.edit_options, args[1]);
else
  return E_PERM;
endif
