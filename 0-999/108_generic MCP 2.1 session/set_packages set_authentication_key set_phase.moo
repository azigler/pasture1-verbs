#108:"set_packages set_authentication_key set_phase"   this none this rxd

"This is the standard :set_foo verb.  It allows the property to be set if called by this or called with adequate permissions (this's owner or wizardly).";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  return this.(verb[5..length(verb)]) = args[1];
else
  return E_PERM;
endif
