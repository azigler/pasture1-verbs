#9:set_text   this none this rxd

cp = caller_perms();
newtext = args[1];
if ($perm_utils:controls(cp, this) || this:is_writable_by(cp))
  if (typeof(newtext) == LIST)
    this.text = newtext;
  else
    return E_TYPE;
  endif
else
  return E_PERM;
endif
