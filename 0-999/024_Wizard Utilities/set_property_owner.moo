#24:set_property_owner   this none this rxd

":set_property_owner(object,prop,newowner[,suspendok])  changes the ownership of object.prop to newowner.  If the property is !c, changes the ownership on all of the descendents as well.  Otherwise, we just chown the property on the object itself and give a warning if newowner!=object.owner (--Rog thinks this is a server bug that one is able to do this at all...).";
{object, pname, newowner, ?suspendok = 0} = args;
if (!caller_perms().wizard)
  return E_PERM;
elseif (!(info = `property_info(object, pname) ! ANY'))
  "... handles E_PROPNF and invalid object errors...";
  return info;
elseif (!is_player(newowner))
  return E_INVARG;
elseif (index(info[2], "c"))
  if (suspendok / 2)
    "...(recursive call)...";
    "...child property is +c while parent is -c??...RUN AWAY!!";
    return E_NONE;
  else
    set_property_info(object, pname, listset(info, newowner, 1));
    return newowner == object.owner || E_NONE;
  endif
else
  set_property_info(object, pname, listset(info, newowner, 1));
  if (suspendok % 2 && (ticks_left() < 10000 || seconds_left() < 2))
    suspend(0);
  endif
  suspendok = 2 + suspendok;
  for c in (children(object))
    this:set_property_owner(c, pname, newowner, suspendok);
  endfor
  return 1;
endif
