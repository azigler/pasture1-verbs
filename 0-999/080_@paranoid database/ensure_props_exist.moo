#80:ensure_props_exist   this none this rxd

"*Must* be called with PDATA first, and LINES second.";
if (caller != this && !caller_perms().wizard)
  return E_PERM;
else
  try
    this.(args[2]);
  except (E_PROPNF)
    add_property(this, args[2], {}, {$hacker, ""});
  endtry
  try
    this.(args[3]);
  except (E_PROPNF)
    add_property(this, args[3], 5, {$hacker, ""});
  endtry
endif
