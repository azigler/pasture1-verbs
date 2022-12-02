#55:_reverse_suspended   this none this rxd

":_reverse(@list) => reversed list";
set_task_perms(caller_perms());
$command_utils:suspend_if_needed(0);
if (length(args) > 50)
  return {@this:_reverse_suspended(@args[$ / 2 + 1..$]), @this:_reverse_suspended(@args[1..$ / 2])};
endif
l = {};
for a in (args)
  l = listinsert(l, a);
endfor
return l;
