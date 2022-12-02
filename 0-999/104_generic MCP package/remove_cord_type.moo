#104:remove_cord_type   this none this rxd

"Usage:  :remove_cord_type(cord_type)";
"";
{cord_type} = args;
if (caller == this || $perm_utils:controls(caller_perms(), this))
  return this.cord_types = setremove(this.cord_types, cord_type);
else
  raise(E_PERM);
endif
