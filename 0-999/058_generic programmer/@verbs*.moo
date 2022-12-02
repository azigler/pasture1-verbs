#58:@verbs*   any none none rd

set_task_perms(player);
if (!dobjstr)
  try
    if (verb[7] != "(" && verb[$] != ")")
      player:tell("Usage:  @verbs <object>");
      return;
    else
      dobjstr = verb[8..$ - 1];
    endif
  except (E_RANGE)
    return player:tell("Usage:  @verbs <object>");
  endtry
endif
thing = player:my_match_object(dobjstr);
if (!$command_utils:object_match_failed(thing, dobjstr))
  verbs = $object_utils:accessible_verbs(thing);
  player:tell(";verbs(", thing, ") => ", toliteral(verbs));
endif
