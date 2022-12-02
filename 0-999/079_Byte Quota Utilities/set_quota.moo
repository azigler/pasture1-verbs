#79:set_quota   this none this rxd

"Set args[1]'s quota to args[2]";
if (caller_perms().wizard || caller == this || this:can_touch(caller_perms()))
  "Size_quota[1] is the total quota permitted.";
  return args[1].size_quota[1] = args[2];
else
  return E_PERM;
endif
