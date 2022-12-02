#88:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  if ($code_utils:verb_location() == this)
    this.rooms = {};
  else
    clear_property(this, "rooms");
  endif
  this.features = {$pasting_feature, $stage_talk};
endif
