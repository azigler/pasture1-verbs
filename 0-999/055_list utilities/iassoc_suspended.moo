#55:iassoc_suspended   this none this rxd

"Copied from Moo_tilities (#332):iassoc_suspended by Mooshie (#106469) Wed Mar 18 19:27:53 1998 PST";
"Usage: iassoc_suspended(ANY target, LIST list [, INT index [, INT suspend-for ]]) => Returns the index of the first element of `list' whose own index-th element is target. Index defaults to 1.";
"Returns 0 if no such element is found.";
"Suspends as needed. Suspend length defaults to 0.";
set_task_perms(caller_perms());
{target, thelist, ?indx = 1, ?suspend_for = 0} = args;
cu = $command_utils;
for element in (thelist)
  if (`element[indx] == target ! E_RANGE, E_TYPE => 0' && typeof(element) == LIST)
    return element in thelist;
  endif
  cu:suspend_if_needed(suspend_for);
endfor
return 0;
"Mooshie (#106469) - Tue Feb 10, PST - :assoc_suspended does a set_task_perms, why shouldn't this?";
