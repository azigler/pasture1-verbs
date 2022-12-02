#88:teleport   this none this rxd

"Teleport a player or object. For printing messages, there are three cases: (1) teleport self (2) teleport other player (3) teleport object. There's a spot of complexity for handling the invalid location #-1.";
set_task_perms(caller == this ? this | $no_one);
{thing, dest} = args;
source = thing.location;
if (valid(dest))
  dest_name = dest.name;
else
  dest_name = tostr(dest);
endif
if (source == dest)
  player:tell(thing.name, " is already at ", dest_name, ".");
  return;
endif
thing:moveto(dest);
if (thing.location == dest)
  tsd = {thing, source, dest};
  if (thing == player)
    this:teleport_messages(@tsd, this:self_port_msg(@tsd), this:oself_port_msg(@tsd), this:self_arrive_msg(@tsd), "");
  elseif (is_player(thing))
    this:teleport_messages(@tsd, this:player_port_msg(@tsd), this:oplayer_port_msg(@tsd), this:player_arrive_msg(@tsd), this:victim_port_msg(@tsd));
  else
    this:teleport_messages(@tsd, this:thing_port_msg(@tsd), this:othing_port_msg(@tsd), this:thing_arrive_msg(@tsd), this:object_port_msg(@tsd));
  endif
elseif (thing.location == source)
  if ($object_utils:contains(thing, dest))
    player:tell("Ooh, it's all twisty. ", dest_name, " is inside ", thing.name, ".");
  else
    if ($object_utils:has_property(thing, "po"))
      pronoun = thing.po;
    else
      pronoun = "it";
    endif
    player:tell("Either ", thing.name, " doesn't want to go, or ", dest_name, " didn't accept ", pronoun, ".");
  endif
else
  thing_name = thing == player ? "you" | thing.name;
  player:tell("A strange force deflects ", thing_name, " from the destination.");
endif
