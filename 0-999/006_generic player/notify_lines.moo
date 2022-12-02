#6:notify_lines   this none this rxd

if ($perm_utils:controls(caller_perms(), this) || caller == this || caller_perms() == this)
  set_task_perms(caller_perms());
  for line in (typeof(lines = args[1]) != LIST ? {lines} | lines)
    this:notify(tostr(line));
  endfor
else
  return E_PERM;
endif
