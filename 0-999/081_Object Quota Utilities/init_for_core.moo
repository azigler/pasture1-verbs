#81:init_for_core   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  pass(@args);
  "Uncomment this if you want to send the core out with object quota.";
  "  $quota_utils = this";
endif
