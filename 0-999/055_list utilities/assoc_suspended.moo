#55:assoc_suspended   this none this rxd

"Copied from Moo_tilities (#332):assoc_suspended by Mooshie (#106469) Wed Mar 18 19:27:54 1998 PST";
"Usage: assoc_suspended(ANY target, LIST list [, INT index [, INT suspend-for ])) => Returns the first element of `list' whose own index-th element is target.  Index defaults to 1.";
"Returns {} if no such element is found.";
"Suspends as necessary. Suspend length defaults to 0.";
set_task_perms(caller_perms());
{target, thelist, ?indx = 1, ?suspend_for = 0} = args;
cu = $command_utils;
for t in (thelist)
  if (`t[indx] == target ! E_TYPE => 0')
    if (typeof(t) == LIST && length(t) >= indx)
      return t;
    endif
  endif
  cu:suspend_if_needed(suspend_for);
endfor
return {};
