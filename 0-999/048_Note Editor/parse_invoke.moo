#48:parse_invoke   this none this rxd

":parse_invoke(string,verb)";
" string is the actual commandline string indicating what we are to edit";
" verb is the command verb that is attempting to invoke the editor";
if (caller != this)
  raise(E_PERM);
elseif (!(string = args[1]))
  player:tell_lines({"Usage:  " + args[2] + " <note>   (where <note> is some note object)", "        " + args[2] + "          (continues editing an unsaved note)"});
elseif (1 == (note = this:note_match_failed(string)))
elseif (ERR == typeof(text = this:note_text(note)))
  player:tell("Couldn't retrieve text:  ", text);
elseif (player:edit_option("local") == 0 && $edit_utils:get_option("default_editor", player))
  fork (0)
    text = $edit_utils:editor(!text ? {} | text);
    result = $note_editor:set_note_text(note, text);
    if (typeof(result) == ERR)
      player:tell("Unable to set text: ", e[2]);
    else
      player:tell("Edited ", note[2], " of ", $su:nn(note[1]), ".");
    endif
  endfork
  kill_task(task_id());
else
  return {note, text};
endif
return 0;
