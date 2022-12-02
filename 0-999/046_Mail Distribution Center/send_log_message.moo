#46:send_log_message   this none this rxd

"send_log_message(perms,from,rcpt-list,hdrs,msg) -- formats and sends a mail message. hders is either the text of the subject line, or a {subject,{reply-to,...}} list.";
"KLUDGE.  this may go away.";
"Send a message while supplying a different permission for use by :mail_forward to determine moderation action.";
"Return E_PERM unless called by a wizard.";
"Return {0, @invalid_rcpts} if rcpt-list contains any invalid addresses.  No mail is sent in this case.";
"Return {1, @actual_rcpts} if successful.";
{perms, from, to, hdrs, msg} = args;
if (caller_perms().wizard)
  text = $mail_agent:make_message(from, to, hdrs, msg);
  return this:raw_send(text, to, perms);
else
  return E_PERM;
endif
