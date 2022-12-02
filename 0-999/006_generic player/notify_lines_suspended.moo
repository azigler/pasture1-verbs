#6:notify_lines_suspended   this none this rxd

if ($perm_utils:controls(caller_perms(), this) || caller == this || caller_perms() == this)
  set_task_perms(caller_perms());
  for line in (typeof(lines = args[1]) != LIST ? {lines} | lines)
    $command_utils:suspend_if_needed(0);
    this:notify(tostr(line));
  endfor
else
  return E_PERM;
endif
