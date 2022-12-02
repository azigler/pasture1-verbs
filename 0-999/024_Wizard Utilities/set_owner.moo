#24:set_owner   this none this rxd

":set_owner(object,newowner[,suspendok])  does object.owner=newowner, taking care of c properties as well.  This should be used anyplace one is contemplating doing object.owner=newowner, since the latter leaves ownership of c properties unchanged.  (--Rog thinks this is a server bug). If force is specified and the object is already owned by newowner, c property ownership will proceed.";
{object, newowner, ?suspendok = 0, ?force = 0} = args;
if (!valid(object))
  return E_INVIND;
elseif (!caller_perms().wizard)
  return E_PERM;
elseif (!(valid(newowner) && is_player(newowner)))
  return E_INVARG;
elseif (object.owner == newowner && !force)
  return 1;
endif
oldowner = object.owner;
object.owner = newowner;
for pname in ($object_utils:all_properties(object))
  if (suspendok && (ticks_left() < 5000 || seconds_left() < 2))
    suspend(0);
  endif
  perms = property_info(object, pname)[2];
  if (index(perms, "c"))
    set_property_info(object, pname, {newowner, perms});
  endif
endfor
if ($object_utils:isa(oldowner, $player))
  if (is_player(oldowner) && object != oldowner)
    $quota_utils:reimburse_quota(oldowner, object);
  endif
  if (typeof(oldowner.owned_objects) == LIST)
    oldowner.owned_objects = setremove(oldowner.owned_objects, object);
  endif
endif
if ($object_utils:isa(newowner, $player))
  if (object != newowner)
    $quota_utils:charge_quota(newowner, object);
  endif
  if (typeof(newowner.owned_objects) == LIST)
    newowner.owned_objects = setadd(newowner.owned_objects, object);
  endif
endif
return 1;
