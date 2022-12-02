#46:"kept_msg_seq unkept_msg_seq"   this none this rxd

":kept_msg_seq([mask])";
" => msg_seq of messages that are marked kept";
":unkept_msg_seq([mask])";
" => msg_seq of messages that are not marked kept";
set_task_perms(caller_perms());
{?mask = {1}} = args;
if (k = verb == "kept_msg_seq")
  kseq = $seq_utils:intersection(mask, caller.messages_kept);
else
  kseq = $seq_utils:intersection(mask, $seq_utils:range(1, caller:length_all_msgs()), $seq_utils:complement(caller.messages_kept));
endif
return kseq;
