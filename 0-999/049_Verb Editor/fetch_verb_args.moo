#49:fetch_verb_args   this none this rxd

"WIZARDLY";
if (caller != $verb_editor || caller_perms() != $verb_editor.owner)
  raise(E_PERM);
else
  set_task_perms(player);
  return `verb_args(args[1], args[2]) ! ANY';
endif
