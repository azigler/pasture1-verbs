#48:set_note_text   this none this rxd

"WIZARDLY";
if (caller != $note_editor || caller_perms() != $note_editor.owner)
  return E_PERM;
endif
set_task_perms(player);
attempt = E_NONE;
if (typeof(spec = args[1]) == OBJ)
  return spec:set_text(args[2]);
elseif ($object_utils:has_callable_verb(spec[1], "set_" + spec[2]))
  attempt = spec[1]:("set_" + spec[2])(args[2]);
endif
if (typeof(attempt) == ERR)
  return `spec[1].(spec[2]) = args[2] ! ANY';
else
  return attempt;
endif
