#52:branches_suspended   this none this rxd

":branches_suspended (OBJ object) => {OBJs} all descendants of <object> that";
"                                           have children.";
set_task_perms(caller_perms());
r = args[1..1];
i = 1;
while (i <= length(r))
  if (kids = children(r[i]))
    r[i + 1..i] = kids;
    i = i + 1;
  else
    r[i..i] = {};
  endif
  $command_utils:suspend_if_needed(0);
endwhile
return r;
