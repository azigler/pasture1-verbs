#49:set_verb_code   this none this rxd

"WIZARDLY";
if (caller != $verb_editor || caller_perms() != $verb_editor.owner)
  return E_PERM;
else
  set_task_perms(player);
  return `set_verb_code(args[1], args[2], args[3]) ! ANY';
endif
