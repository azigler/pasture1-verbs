#109:remove_package   this none this rxd

{name} = args;
if (caller == this || $perm_utils:controls(caller_perms(), this))
  if (idx = name in this.package_names)
    this.package_names = listdelete(this.package_names, idx);
    this.packages = listdelete(this.packages, idx);
  else
    raise(E_INVARG, "Not a defined package");
  endif
endif
