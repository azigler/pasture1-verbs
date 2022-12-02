#4:init_for_core   this none this rxd

if (caller_perms().wizard)
  if (this == $builder)
    this.build_options = {};
  else
    clear_property(this, "build_options");
  endif
  return pass(@args);
endif
