#6:@edit   any any any rd

"Calls the verb editor on verbs, the note editor on properties, and on anything else assumes it's an object for which you want to edit the .description.";
if (!args)
  (player in $note_editor.active ? $note_editor | $verb_editor):invoke(dobjstr, verb);
elseif ($code_utils:parse_verbref(args[1]))
  if (player.programmer)
    $verb_editor:invoke(argstr, verb);
  else
    player:notify("You need to be a programmer to do this.");
    player:notify("If you want to become a programmer, talk to a wizard.");
    return;
  endif
else
  $note_editor:invoke(dobjstr, verb);
endif
