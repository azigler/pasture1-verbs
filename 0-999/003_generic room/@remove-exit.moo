#3:@remove-exit   any none none rd

set_task_perms(player);
if (!dobjstr)
  player:tell("Usage:  @remove-exit <exit>");
  return;
endif
exit = this:match_object(dobjstr);
if (!(exit in this.exits))
  if ($command_utils:object_match_failed(exit, dobjstr))
    return;
  endif
  player:tell("Couldn't find \"", dobjstr, "\" in the exits list of ", this.name, ".");
  return;
elseif (!this:remove_exit(exit))
  player:tell("Sorry, but you do not have permission to remove exits from this room.");
else
  name = valid(exit) ? exit.name | "<recycled>";
  player:tell("Exit ", exit, " (", name, ") removed from exit list of ", this.name, " (", this, ").");
endif
