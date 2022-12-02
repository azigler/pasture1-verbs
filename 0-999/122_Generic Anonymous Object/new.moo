#122:new   this none this rxd

{?owner = caller_perms()} = args;
if (owner != caller_perms() && !caller_perms().wizard)
  return E_PERM;
endif
return create(this, owner, 1);
"This could potentially allow people to skirt quota since we're not tracking it.";
"I'm not sure of the best fix, though. Maybe make bf_create handle it?";
