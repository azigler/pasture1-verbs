#80:erase_data   this none this rxd

who = args[1];
if ($perm_utils:controls(caller_perms(), who))
  d = tostr(who, "pdata");
  "OK if this would toss its cookies if no prop, no damage.";
  `this.(d) = {} ! ANY';
else
  return E_PERM;
endif
