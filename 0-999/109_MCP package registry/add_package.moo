#109:add_package   this none this rxd

{name, package} = args;
if (caller == this || $perm_utils:controls(caller_perms(), this))
  if (name in this.package_names)
    raise(E_INVARG, "Another package with that name already exists");
  elseif (package in this.packages)
    raise(E_INVARG, "That package already is registered under a different name.");
  else
    this.package_names = {@this.package_names, name};
    this.packages = {@this.packages, package};
  endif
endif
