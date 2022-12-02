#79:reimburse_quota   this none this rxd

"reimburse args[1] for the quota required to own args[2]";
{who, what} = args;
if (caller == this || caller_perms().wizard)
  usage_index = 2;
  unmeasured_index = 4;
  if (valid(who) && is_player(who) && $object_utils:has_property(what, "object_size") && !is_clear_property(who, "size_quota"))
    object_size = what.object_size[1];
    if (object_size <= 0)
      who.size_quota[unmeasured_index] = who.size_quota[unmeasured_index] - 1;
    else
      who.size_quota[usage_index] = who.size_quota[usage_index] - object_size;
    endif
  endif
else
  return E_PERM;
endif
