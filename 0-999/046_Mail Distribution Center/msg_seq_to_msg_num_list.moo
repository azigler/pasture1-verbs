#46:msg_seq_to_msg_num_list   this none this rxd

":msg_seq_to_msg_num_list(msg_seq) => list of corresponding message numbers";
set_task_perms(caller_perms());
return $list_utils:slice(caller:messages_in_seq(args[1]));
