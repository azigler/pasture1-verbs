#8:"@lock_for_open @lock-for-open"   this (with/using) any rd

set_task_perms(player);
key = $lock_utils:parse_keyexp(iobjstr, player);
if (typeof(key) == STR)
  player:tell("That key expression is malformed:");
  player:tell("  ", key);
else
  try
    this.open_key = key;
    player:tell("Locked opening of ", this.name, " with this key:");
    player:tell("  ", $lock_utils:unparse_key(key));
  except error (ANY)
    player:tell(error[2], ".");
  endtry
endif
