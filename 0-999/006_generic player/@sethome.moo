#6:@sethome   none none none rd

set_task_perms(this);
here = this.location;
if (!$perm_utils:controls(player, player))
  player:notify("Players who do not own themselves may not modify their home.");
elseif (!$object_utils:has_callable_verb(here, "accept_for_abode"))
  player:notify("This is a pretty odd place.  You should make your home in an actual room.");
elseif (here:accept_for_abode(this))
  this.home = here;
  player:notify(tostr(here.name, " is your new home."));
else
  player:notify(tostr("This place doesn't want to be your home.  Contact ", here.owner.name, " to be added to the residents list of this place, or choose another place as your home."));
endif
