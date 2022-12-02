#79:charge_quota   this none this rxd

"Charge args[1] for the quota required to own args[2]";
{who, what} = args;
if (caller == this || caller_perms().wizard)
  usage_index = 2;
  unmeasured_index = 4;
  object_size = $object_utils:has_property(what, "object_size") ? what.object_size[1] | -1;
  if (object_size <= 0)
    who.size_quota[unmeasured_index] = who.size_quota[unmeasured_index] + 1;
  else
    who.size_quota[usage_index] = who.size_quota[usage_index] + object_size;
  endif
else
  return E_PERM;
endif
