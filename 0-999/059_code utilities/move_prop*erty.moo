#59:move_prop*erty   this none this rxd

":move_prop(OBJ from, STR prop name, OBJ to, [STR new prop name]) -> Moves the specified property and its contents from one object to another. Returns {OBJ, property name} where the property now resides if successful, error if not. To succeed, caller_perms() must control both objects and own the property, unless called with wizard perms. Supplying a fourth argument gives the property a new name on the new object.";
who = caller_perms();
{from, origprop, to, ?destprop = origprop} = args;
if (typeof(from) != OBJ || typeof(to) != OBJ || typeof(origprop) != STR || typeof(destprop) != STR)
  return E_TYPE;
elseif (!valid(from) || !valid(to))
  return E_INVARG;
elseif (from == to && destprop == origprop)
  "Moving same prop onto the same object puts the contents in the wrong one. Just not allow";
  return E_NACC;
elseif (!$perm_utils:controls(who, from) && !from.w || (!$perm_utils:controls(who, to) && !to.w))
  "caller_perms() is not allowed to hack on either object in question";
  return E_PERM;
elseif (!$object_utils:defines_property(from, origprop))
  "property is not defined on the from object";
  return E_PROPNF;
elseif ((pinfo = property_info(from, origprop)) && !$perm_utils:controls(who, pinfo[1]))
  "caller_perms() is not permitted to add a property with the existing property owner";
  return E_PERM;
elseif (!who.programmer)
  return E_PERM;
else
  "we now know that the caller's perms control the objects or the objects are writable, and we know that the caller's perms control the prospective property owner (by more traditional means)";
  pdata = from.(origprop);
  pname = destprop == origprop ? origprop | destprop;
  if (typeof(res = `add_property(to, pname, pdata, pinfo) ! ANY') == ERR)
    return res;
  else
    delete_property(from, origprop);
    return {to, pname};
  endif
endif
