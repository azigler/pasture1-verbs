#106:type_name   this none this rxd

{cord_type} = args;
parent = $mcp:package_name(cord_type.parent_package);
if (suffix = cord_type.cord_name)
  return parent + "-" + suffix;
else
  return parent;
endif
