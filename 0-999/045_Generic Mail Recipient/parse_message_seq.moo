#45:"parse_message_seq from_msg_seq %from_msg_seq to_msg_seq %to_msg_seq subject_msg_seq body_msg_seq kept_msg_seq unkept_msg_seq display_seq_headers display_seq_full messages_in_seq list_rmm new_message_num length_num_le length_date_le length_all_msgs exists_num_eq msg_seq_to_msg_num_list msg_seq_to_msg_num_string"   this none this rxd

":parse_message_seq(strings,cur) => {msg_seq,@unused_strings} or string error";
"";
":from_msg_seq(olist)     => msg_seq of messages from those people";
":%from_msg_seq(strings)  => msg_seq of messages with strings in the From: line";
":to_msg_seq(olist)       => msg_seq of messages to those people";
":%to_msg_seq(strings)    => msg_seq of messages with strings in the To: line";
":subject_msg_seq(target) => msg_seq of messages with target in the Subject:";
":body_msg_seq(target)    => msg_seq of messages with target in the body";
":new_message_num()    => number that the next incoming message will receive.";
":length_num_le(num)   => number of messages in folder numbered <= num";
":length_date_le(date) => number of messages in folder dated <= date";
":length_all_msgs()    => number of messages in folder";
":exists_num_eq(num)   => index of message in folder numbered == num, or 0";
"";
":display_seq_headers(msg_seq[,cur])   display message summary lines";
":display_seq_full(msg_seq[,preamble]) display entire messages";
"            => number of final message displayed";
":list_rmm() displays contents of .messages_going.";
"            => the number of messages in .messages_going.";
"";
":messages_in_seq(msg_seq) => list of messages in msg_seq on folder";
"";
"See the corresponding routines on $mail_agent for more detail.";
return this:ok(caller, caller_perms()) ? $mail_agent:(verb)(@args) | E_PERM;
