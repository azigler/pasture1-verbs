#49:verb_name   this none this rxd

"verb_name(object, vname)";
"Find vname on object and return its full name (quoted).";
"This is useful for when we're working with verb numbers.";
if (caller != $verb_editor || caller_perms() != $verb_editor.owner)
  return E_PERM;
else
  set_task_perms(player);
  given = args[2];
  if (typeof(info = `verb_info(args[1], given) ! ANY') == ERR)
    return tostr(given, "[", info, "]");
  elseif (info[3] == given)
    return given;
  else
    return tostr(given, "/\"", info[3], "\"");
  endif
endif
