#105:handle_can   this none this rxd

if (caller == this)
  {connection, package, minv, maxv, @rest} = args;
  if (valid(pkg = $mcp.registry:match_package(package)))
    if (version = $mcp:compare_version_range({minv, maxv}, pkg.version_range))
      connection:add_package(pkg, version);
    endif
  endif
endif
