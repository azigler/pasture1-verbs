#88:set_owned_objects   this none this rxd

":set_owned_objects( LIST owned-objects list )";
"  -- set your .owned_objects, ordered as you please";
"  -- no, it will NOT let you set to to anything you want";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  new = args[1];
  old = this.owned_objects;
  "make sure they're the same";
  if (length(new) != length(old))
    return E_INVARG;
  endif
  for i in (new)
    old = setremove(old, i);
  endfor
  if (old)
    "something's funky";
    return E_INVARG;
  endif
  return this.owned_objects = new;
else
  return E_PERM;
endif
