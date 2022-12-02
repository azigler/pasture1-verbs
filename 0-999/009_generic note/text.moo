#9:text   this none this rxd

cp = caller_perms();
if ($perm_utils:controls(cp, this) || this:is_readable_by(cp))
  return this.text;
else
  return E_PERM;
endif
