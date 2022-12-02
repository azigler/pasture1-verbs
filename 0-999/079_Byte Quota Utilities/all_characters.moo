#79:all_characters   this none this rxd

{who} = args;
if (caller != this && !this:can_peek(caller_perms(), who))
  return E_PERM;
elseif ($object_utils:has_property($local, "second_char_registry"))
  seconds = $local.second_char_registry:all_second_chars(who);
  if (seconds == E_INVARG)
    return {who};
  else
    return seconds;
  endif
else
  return {who};
endif
