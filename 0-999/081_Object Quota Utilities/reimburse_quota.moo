#81:reimburse_quota   this none this rxd

"Reimburse args[1] for the quota required to own args[2]";
{who, what} = args;
if (caller == this || caller_perms().wizard)
  who.ownership_quota = who.ownership_quota + 1;
else
  return E_PERM;
endif
