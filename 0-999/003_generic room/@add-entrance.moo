#3:@add-entrance   any none none rd

set_task_perms(player);
if (!dobjstr)
  player:tell("Usage:  @add-entrance <exit-number>");
  return;
endif
exit = this:match_object(dobjstr);
if ($command_utils:object_match_failed(exit, dobjstr))
  return;
endif
if (!($exit in $object_utils:ancestors(exit)))
  player:tell("That doesn't look like an exit object to me...");
  return;
endif
try
  dest = exit.dest;
except (E_PERM)
  player:tell("You can't read the exit's destination to check that it's consistent!");
  return;
endtry
if (dest != this)
  player:tell("That exit doesn't lead here!");
  return;
endif
if (!this:add_entrance(exit))
  player:tell("Sorry, but you must not have permission to add entrances to this room.");
else
  player:tell("You have added ", exit, " as an entrance that gets here via ", $string_utils:english_list(setadd(exit.aliases, exit.name)), ".");
endif
