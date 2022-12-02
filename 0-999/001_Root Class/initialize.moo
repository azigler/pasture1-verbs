#1:initialize   this none this rxd

if (typeof(this) != ANON && typeof(this.owner.owned_objects) == LIST)
  this.owner.owned_objects = setadd(this.owner.owned_objects, this);
endif
if (caller == this || $perm_utils:controls(caller_perms(), this))
  if (is_clear_property(this, "object_size"))
    "If this isn't clear, then we're being hacked.";
    this.object_size = {0, 0};
  endif
  this.key = 0;
else
  return E_PERM;
endif
