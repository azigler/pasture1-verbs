#46:msg_seq_to_msg_num_string   this none this rxd

":msg_seq_to_msg_num_string(msg_seq) => string giving the corresponding message numbers";
set_task_perms(caller_perms());
return $seq_utils:tostr($seq_utils:from_list($list_utils:slice(caller:messages_in_seq(args[1]))));
