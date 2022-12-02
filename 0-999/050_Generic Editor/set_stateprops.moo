#50:set_stateprops   this none this rxd

remove = length(args) < 2;
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (!(length(args) in {1, 2}))
  return E_ARGS;
elseif (typeof(prop = args[1]) != STR)
  return E_TYPE;
elseif (i = $list_utils:iassoc(prop, this.stateprops))
  if (!remove)
    this.stateprops[i] = {prop, args[2]};
  elseif ($object_utils:has_property(parent(this), prop))
    return E_NACC;
  else
    this.stateprops = listdelete(this.stateprops, i);
  endif
elseif (remove)
elseif (prop in `properties(this) ! ANY => {}')
  if (this:_stateprop_length(prop) != length(this.active))
    return E_RANGE;
  endif
  this.stateprops = {{prop, args[2]}, @this.stateprops};
else
  return $object_utils:has_property(this, prop) ? E_NACC | E_PROPNF;
endif
return 0;
