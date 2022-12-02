#45:annotate_message_seq   this none this rxd

"annotate_message_seq(note, \"append\"|\"prepend\", message_seq) ;";
"";
"Prepend or append (default is prepend) note (a list of strings) to each message in message_seq";
"Recipient must be annotatable (:is_annotatable_by() returns 1) by the caller for this to work.";
{note, appendprepend, message_seq} = args;
if (!this:ok_annotate(caller, caller_perms()))
  return E_PERM;
endif
for i in ($seq_utils:tolist(message_seq))
  body = this:message_body_by_index(i);
  if (appendprepend == "append")
    body = {@body, "", @note};
  else
    body = {@note, "", @body};
  endif
  this:set_message_body_by_index(i, body);
endfor
return 1;
"Copied from annotatetest (#87053):annotate_message_seq [verb author Puff (#1449)] at Mon Feb 14 14:04:56 2005 PST";
