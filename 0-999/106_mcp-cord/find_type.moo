#106:find_type   this none this rxd

{name} = args;
for i in ($object_utils:leaves($mcp.cord.type_root))
  if (name == $mcp.registry:package_name(i.parent_package) + "-" + i.cord_name)
    return i;
  endif
endfor
return $failed_Match;
