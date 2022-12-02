#48:note_text   this none this rxd

"WIZARDLY";
if (caller != $note_editor || caller_perms() != $note_editor.owner)
  return E_PERM;
endif
set_task_perms(player);
if (typeof(spec = args[1]) == OBJ)
  text = spec:text();
else
  text = `spec[1].(spec[2]) ! ANY';
endif
if (typeof(text) in {ERR, STR, LIST})
  return text;
else
  return E_TYPE;
endif
