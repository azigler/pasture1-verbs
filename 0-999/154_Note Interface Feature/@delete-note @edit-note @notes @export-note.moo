#154:"@delete-note @edit-note @notes @export-note"   any any any rxd

standard_args = {1, args ? argstr | ""};
if (verb == "@notes")
  if (args && argstr in {"?", "help"})
    return player:tell_lines(this.help_msg);
  else
    return this.utils:main_notes_menu(@standard_args);
  endif
elseif (verb == "@delete-note")
  call_verb = "do_delete_note";
elseif (verb == "@edit-note")
  call_verb = "do_edit_note";
elseif (verb == "@export-note")
  call_verb = "do_export_note";
else
  return raise(E_INVARD, tostr("Function ", verb, " not found."));
endif
this.utils:note_menu(call_verb, @standard_args);
