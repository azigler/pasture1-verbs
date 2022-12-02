#3:@exits   none none none rxd

if (!$perm_utils:controls(valid(caller_perms()) ? caller_perms() | player, this))
  player:tell("Sorry, only the owner of a room may list its exits.");
elseif (this.exits == {})
  player:tell("This room has no conventional exits.");
else
  try
    for exit in (this.exits)
      try
        player:tell(exit.name, " (", exit, ") leads to ", valid(exit.dest) ? exit.dest.name | "???", " (", exit.dest, ") via {", $string_utils:from_list(exit.aliases, ", "), "}.");
      except (ANY)
        player:tell("Bad exit or missing .dest property:  ", $string_utils:nn(exit));
        continue exit;
      endtry
    endfor
  except (E_TYPE)
    player:tell("Bad .exits property. This should be a list of exit objects. Please fix this.");
  endtry
endif
