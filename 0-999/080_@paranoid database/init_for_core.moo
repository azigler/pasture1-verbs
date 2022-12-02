#80:init_for_core   this none this rxd

if (!caller_perms().wizard)
  return;
else
  for x in (properties(this))
    if (x[1] == "#")
      delete_property(this, x);
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  pass(@args);
endif
