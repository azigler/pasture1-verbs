#3:@entrances   none none none rd

if (!$perm_utils:controls(valid(caller_perms()) ? caller_perms() | player, this))
  player:tell("Sorry, only the owner of a room may list its entrances.");
elseif (this.entrances == {})
  player:tell("This room has no conventional entrances.");
else
  try
    for exit in (this.entrances)
      try
        player:tell(exit.name, " (", exit, ") comes from ", valid(exit.source) ? exit.source.name | "???", " (", exit.source, ") via {", $string_utils:from_list(exit.aliases, ", "), "}.");
      except (ANY)
        player:tell("Bad entrance object or missing .source property: ", $string_utils:nn(exit));
        continue exit;
      endtry
    endfor
  except (E_TYPE)
    player:tell("Bad .entrances property. This should be a list of exit objects. Please fix this.");
  endtry
endif
