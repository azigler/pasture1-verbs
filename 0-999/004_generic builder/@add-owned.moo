#4:@add-owned   any none none rd

if (player != this)
  player:tell("Permission Denied");
  return E_PERM;
endif
if (!valid(dobj))
  player:tell("Don't understand `", dobjstr, "' as an object to add.");
elseif (dobj.owner != player)
  player:tell("You don't own ", dobj.name, ".");
elseif (dobj in player.owned_objects)
  player:tell(dobj.name, " is already recorded in your .owned_objects.");
else
  player.owned_objects = setadd(player.owned_objects, dobj);
  player:tell("Added ", dobj, " to your .owned_objects.");
endif
