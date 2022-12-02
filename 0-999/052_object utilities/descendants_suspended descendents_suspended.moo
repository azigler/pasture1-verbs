#52:"descendants_suspended descendents_suspended"   this none this rxd

":descendants_suspended (OBJ object) => {OBJs} all nested children of <object>";
set_task_perms(caller_perms());
r = children(args[1]);
i = 1;
while (i <= length(r))
  if (kids = children(r[i]))
    r = {@r, @kids};
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endwhile
return r;
