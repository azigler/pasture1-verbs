#45:"undo_rmm expunge_rmm renumber keep_message_seq set_message_body_by_index"   this none this rxd

":rm_message_seq(msg_seq) removes the given sequence of from folder";
"               => string giving msg numbers removed";
":list_rmm()    displays contents of .messages_going.";
"               => number of messages in .messages_going.";
":undo_rmm()    restores previously deleted messages from .messages_going.";
"               => msg_seq of restored messages";
":expunge_rmm() destroys contents of .messages_going once and for all.";
"               => number of messages in .messages_going.";
":renumber([cur])  renumbers all messages";
"               => {number of messages,new cur}.";
":set_message_body_by_index(i,newbody)";
"               changes the body of the i-th message.";
"";
"See the corresponding routines on $mail_agent.";
return this:ok_write(caller, caller_perms()) ? $mail_agent:(verb)(@args) | E_PERM;
