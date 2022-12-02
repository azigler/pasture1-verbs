#108:add_package   this none this rxd

{package, version} = args;
if (caller in {$mcp.negotiate, this})
  if (n = $list_utils:iassoc(package, this.packages))
    packages = this.packages;
    packages[n][2] = version;
    this:set_packages(packages);
  else
    this:set_packages({@this.packages, {package, version}});
  endif
  package:initialize_connection(version);
  this:_signal_package_waiter(package, version);
endif
