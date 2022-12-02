#40:"parse_message_seq from_msg_seq %from_msg_seq to_msg_seq %to_msg_seq subject_msg_seq body_msg_seq kept_msg_seq unkept_msg_seq display_seq_headers display_seq_full messages_in_seq list_rmm new_message_num length_num_le length_date_le length_date_gt length_all_msgs exists_num_eq msg_seq_to_msg_num_list msg_seq_to_msg_num_string rm_message_seq undo_rmm expunge_rmm renumber keep_message_seq"   this none this rxd

"parse_message_seq(strings,cur)         => msg_seq";
"messages_in_seq(msg_seq);              => text of messages in msg_seq";
"display_seq_headers(msg_seq[,current]) :displays summary lines of those msgs";
"rmm_message_seq(msg_seq)               => string giving msg numbers removed";
"undo_rmm()    => msg_seq of restored messages";
"expunge_rmm() => number of messages expunged";
"list_rmm()    => number of messages awaiting expunge";
"renumber(cur) => {number of messages in folder, new_cur}";
"";
"See the corresponding routines on $mail_agent.";
if (caller == $mail_agent || $perm_utils:controls(caller_perms(), this))
  set_task_perms(this.owner);
  return $mail_agent:(verb)(@args);
else
  return E_PERM;
endif
