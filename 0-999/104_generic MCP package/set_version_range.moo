#104:set_version_range   this none this rx

"This is the standard :set_foo verb.  It allows the property to be set if called by this or called with adequate permissions (this's owner or wizardly).";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  return this.(verb[5..length(verb)]) = args[1];
else
  return E_PERM;
endif
"version: 1.0 Fox Wed Jul  5 17:58:13 1995 EDT";
