#48:note_match_failed   this none this rxd

if (pp = $code_utils:parse_propref(string = args[1]))
  object = pp[1];
  prop = pp[2];
else
  object = string;
  prop = 0;
endif
if ($command_utils:object_match_failed(note = player:my_match_object(object, this:get_room(player)), object))
elseif (prop)
  if (!$object_utils:has_property(note, prop))
    player:tell(object, " has no \".", prop, "\" property.");
  else
    return {note, prop};
  endif
elseif (!$object_utils:has_callable_verb(note, "text") || !$object_utils:has_callable_verb(note, "set_text"))
  return {note, "description"};
  "... what we used to do.  but why barf?   that's no fun...";
  player:tell(object, "(", note, ") doesn't look like a note.");
else
  return note;
endif
return 1;
