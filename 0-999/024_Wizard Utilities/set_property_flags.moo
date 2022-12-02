#24:set_property_flags   this none this rxd

":set_property_flags(object,prop,flags[,suspendok])  changes the permissions on object.prop to flags.  Unlike a mere set_property_info, this changes the flags on all descendant objects as well.  We also change the ownership on the descendent properties where necessary.";
{object, pname, flags, ?suspendok = 0} = args;
perms = caller_perms();
if (!(info = `property_info(object, pname) ! ANY'))
  "... handles E_PROPNF and invalid object errors...";
  return info;
elseif ($set_utils:difference($string_utils:char_list(flags), {"r", "w", "c"}))
  "...not r, w, or c?...";
  return E_INVARG;
elseif ((pinfo = `property_info(parent(object), pname) ! ANY') && flags != pinfo[2])
  "... property doesn't actually live here...";
  "... only allowed to correct so that this property matches parent...";
  return E_INVARG;
elseif (!(perms.wizard || info[1] == perms))
  "... you have to own the property...";
  return E_PERM;
elseif (!(!(c = index(flags, "c")) == !index(info[2], "c") || $perm_utils:controls(perms, object)))
  "... if you're changing the c flag, you have to own the object...";
  return E_PERM;
else
  if (c)
    set_property_info(object, pname, {object.owner, kflags = flags});
  else
    set_property_info(object, pname, kflags = listset(info, flags, 2));
  endif
  for kid in (children(object))
    this:_set_property_flags(kid, pname, kflags, suspendok);
  endfor
  return 1;
endif
