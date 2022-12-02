#80:get_data   this none this rxd

who = args[1];
if ($perm_utils:controls(caller_perms(), who))
  d = tostr(who, "pdata");
  if (typeof(`this.(d) ! ANY') == LIST)
    return this.(d);
  else
    return {};
  endif
else
  return E_PERM;
endif
