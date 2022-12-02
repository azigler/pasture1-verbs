#31:"set_name set_aliases"   this none this rxd

"disallow guests from setting aliases on themselves";
if ($perm_utils:controls(caller_perms(), this))
  return pass(@args);
else
  return E_PERM;
endif
