#109:"init_for_module init_for_core"   this none this rxd

if (caller_perms().wizard)
  for name in (this.package_names)
    this:remove_package(name);
  endfor
  for x in (children($mcp.package))
    `this:add_package(x.name, x) ! E_INVARG';
  endfor
endif
