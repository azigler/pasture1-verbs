#6:set_home   this none this rxd

"set_home(newhome) attempts to change this.home to newhome";
"E_TYPE   if newhome doesn't have a callable :accept_for_abode verb.";
"E_INVARG if newhome won't accept you as a resident.";
"E_PERM   if you don't own this and aren't its parent.";
"1        if it works.";
newhome = args[1];
if (caller == this || $perm_utils:controls(caller_perms(), this))
  if ($object_utils:has_callable_verb(newhome, "accept_for_abode"))
    if (newhome:accept_for_abode(this))
      return typeof(e = `this.home = args[1] ! ANY') != ERR || e;
    else
      return E_INVARG;
    endif
  else
    return E_TYPE;
  endif
else
  return E_PERM;
endif
