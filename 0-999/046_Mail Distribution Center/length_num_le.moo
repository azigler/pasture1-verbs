#46:length_num_le   this none this rxd

":length_num_le(num) => number of messages in folder numbered <= num";
set_task_perms(caller_perms());
return $list_utils:iassoc_sorted(args[1], caller.messages);
