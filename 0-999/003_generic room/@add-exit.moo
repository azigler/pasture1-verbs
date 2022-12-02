#3:@add-exit   any none none rd

set_task_perms(player);
if (!dobjstr)
  player:tell("Usage:  @add-exit <exit-number>");
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
try
  source = exit.source;
except (E_PERM)
  player:tell("You can't read that exit's source to check that it's consistent!");
  return;
endtry
if (source == $nothing)
  player:tell("That exit's source has not yet been set; set it to be this room, then run @add-exit again.");
  return;
elseif (source != this)
  player:tell("That exit wasn't made to be attached here; it was made as an exit from ", source.name, " (", source, ").");
  return;
elseif (typeof(dest) != OBJ || !valid(dest) || !($room in $object_utils:ancestors(dest)))
  player:tell("That exit doesn't lead to a room!");
  return;
endif
if (!this:add_exit(exit))
  player:tell("Sorry, but you must not have permission to add exits to this room.");
else
  player:tell("You have added ", exit, " as an exit that goes to ", exit.dest.name, " (", exit.dest, ") via ", $string_utils:english_list(setadd(exit.aliases, exit.name)), ".");
endif
