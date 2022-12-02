#94:set_gender   this none this rxd

"set_gender(newgender) attempts to change this.gender to newgender";
"  => E_PERM   if you don't own this or aren't its parent";
"  => Other return values as from $gender_utils:set.";
if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
else
  result = $gender_utils:set(this, args[1]);
  this.gender = typeof(result) == STR ? result | args[1];
  return result;
endif
