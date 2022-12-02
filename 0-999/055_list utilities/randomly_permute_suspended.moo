#55:randomly_permute_suspended   this none this rxd

":randomly_permute_suspended(list) => list with its elements randomly permuted";
"  each of the length(list)! possible permutations is equally likely";
set_task_perms(caller_perms());
plist = {};
for i in [1..length(ulist = args[1])]
  plist = listinsert(plist, ulist[i], random(i));
  $command_utils:suspend_if_needed(0);
endfor
return plist;
