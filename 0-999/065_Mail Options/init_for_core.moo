#65:init_for_core   this none this rx

if (caller_perms().wizard)
  for x in ({"fast_check", "idle_check", "idle_threshold"})
    this:remove_name(x);
    for y in ({"show", "check", "parse"})
      delete_verb(this, y + "_" + x);
      delete_property(this, y + "_" + x);
    endfor
  endfor
  pass(@args);
endif
