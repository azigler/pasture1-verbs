#79:value_bytes   this none this rxd

return value_bytes(args[1]);
set_task_perms(caller_perms());
v = args[1];
t = typeof(v);
if (t == LIST)
  b = (length(v) + 1) * 2 * 4;
  for vv in (v)
    $command_utils:suspend_if_needed(2);
    b = b + this:value_bytes(vv);
  endfor
  return b;
elseif (t == STR)
  return length(v) + 1;
else
  return 0;
endif
