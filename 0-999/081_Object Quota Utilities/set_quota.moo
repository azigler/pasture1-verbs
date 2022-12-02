#81:set_quota   this none this rxd

"Set args[1]'s quota to args[2]";
{who, quota} = args;
if (caller_perms().wizard || caller == this)
  return who.ownership_quota = quota;
else
  return E_PERM;
endif
