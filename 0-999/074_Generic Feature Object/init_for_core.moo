#74:init_for_core   this none this rxd

if ($code_utils:verb_location() == this && caller_perms().wizard)
  this.warehouse = $feature_warehouse;
  `delete_property(this, "guest_ok") ! ANY';
  `delete_verb(this, "set_ok_for_guest_use") ! ANY';
  pass(@args);
endif
