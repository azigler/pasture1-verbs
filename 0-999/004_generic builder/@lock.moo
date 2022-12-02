#4:@lock   any (with/using) any rd

set_task_perms(player);
dobj = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
endif
key = $lock_utils:parse_keyexp(iobjstr, player);
if (typeof(key) == STR)
  player:notify("That key expression is malformed:");
  player:notify(tostr("  ", key));
else
  try
    dobj.key = key;
    player:notify(tostr("Locked ", dobj.name, " to this key:"));
    player:notify(tostr("  ", $lock_utils:unparse_key(key)));
  except error (ANY)
    player:notify(error[2]);
  endtry
endif
