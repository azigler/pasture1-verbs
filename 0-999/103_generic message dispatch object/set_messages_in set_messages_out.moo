#103:"set_messages_in set_messages_out"   this none this rxd

"This is the standard :set_foo verb.  It allows the property to be set if called by this or called with adequate permissions (this's owner or wizardly).";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  return this.(verb[5..length(verb)]) = args[1];
else
  return E_PERM;
endif
