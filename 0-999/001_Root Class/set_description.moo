#1:set_description   this none this rxd

"set_description(newdesc) attempts to change this.description to newdesc";
"  => E_PERM   if you don't own this or aren't its parent";
if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
elseif (typeof(desc = args[1]) in {LIST, STR})
  this.description = desc;
  return 1;
else
  return E_TYPE;
endif
