#46:exists_num_eq   this none this rxd

":exists_num_eq(num) => index of message in folder numbered == num";
set_task_perms(caller_perms());
return (i = $list_utils:iassoc_sorted(args[1], caller.messages)) && (caller.messages[i][1] == args[1] && i);
