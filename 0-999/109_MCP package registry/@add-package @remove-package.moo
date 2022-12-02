#109:"@add-package @remove-package"   any (at/to) this rd

if (!$perm_utils:controls(player, this))
  player:tell("You don't have permission to add or remove MCP 2.1 packages.");
elseif ($command_utils:object_match_failed(dobj, dobjstr))
elseif (!$object_utils:isa(dobj, $mcp.package))
  player:tell(dobj.name, " is not a valid MCP 2.1 package (descendant of ", $mcp.package, ").");
elseif (!$perm_utils:controls(player, dobj))
  player:tell("You don't control ", dobj.name, " in order to add or remove it.");
else
  name = dobj.name;
  package = dobj;
  try
    if (verb == "@add-package")
      this:add_package(name, package);
      player:tell("Added ", package.name, ".");
    else
      this:remove_package(name);
      player:tell("Removed ", package.name, ".");
    endif
  except v (ANY)
    {code, message, value, tb} = v;
    player:tell(code, ": ", message);
  endtry
endif
