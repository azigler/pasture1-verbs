#1:set_aliases   this none this rxd

"set_aliases(alias_list) attempts to change this.aliases to alias_list";
"  => E_PERM   if you don't own this or aren't its parent";
"  => E_TYPE   if alias_list is not a list";
"  => E_INVARG if any element of alias_list is not a string";
"  => 1        if aliases are set exactly as expected (default)";
"  => 0        if aliases were set differently than expected";
"              (children with custom :set_aliases should be aware of this)";
if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
elseif (typeof(aliases = args[1]) != LIST)
  return E_TYPE;
else
  for s in (aliases)
    if (typeof(s) != STR)
      return E_INVARG;
    endif
  endfor
  this.aliases = aliases;
  return 1;
endif
