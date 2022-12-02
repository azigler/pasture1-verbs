#49:verb_args   this none this rxd

"verb_name(object, vname)";
"Find vname on object and return its full name (quoted).";
"This is useful for when we're working with verb numbers.";
if (caller != $verb_editor || caller_perms() != $verb_editor.owner)
  return E_PERM;
else
  set_task_perms(player);
  return $string_utils:from_list(`verb_args(args[1], args[2]) ! ANY', " ");
endif
