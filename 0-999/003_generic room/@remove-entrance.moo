#3:@remove-entrance   any none none rd

set_task_perms(player);
if (!dobjstr)
  player:tell("Usage:  @remove-entrance <entrance>");
  return;
endif
entrance = $string_utils:match(dobjstr, this.entrances, "name", this.entrances, "aliases");
if (!valid(entrance))
  "Try again to parse it.  Maybe they gave object number.  Don't complain if it's invalid though; maybe it's been recycled in some nefarious way.";
  entrance = this:match_object(dobjstr);
endif
if (!(entrance in this.entrances))
  player:tell("Couldn't find \"", dobjstr, "\" in the entrances list of ", this.name, ".");
  return;
elseif (!this:remove_entrance(entrance))
  player:tell("Sorry, but you do not have permission to remove entrances from this room.");
else
  name = valid(entrance) ? entrance.name | "<recycled>";
  player:tell("Entrance ", entrance, " (", name, ") removed from entrance list of ", this.name, " (", this, ").");
endif
