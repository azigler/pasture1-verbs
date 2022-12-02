#49:fetch_verb_code   this none this rxd

"WIZARDLY";
if (caller != $verb_editor || caller_perms() != $verb_editor.owner)
  return E_PERM;
else
  set_task_perms(player);
  return `verb_code(args[1], args[2], !player:edit_option("no_parens")) ! ANY';
endif
