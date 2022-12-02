#46:resend_message   this none this rxd

"resend_message(new_sender,new_rcpts,from,to,hdrs,body)";
" -- reformats and resends a previously sent message to new recipients.";
"msg is the previous message";
"Return E_PERM if new_sender isn't owned by the caller.";
"Return {0, @invalid_rcpts} if new_rcpts contains any invalid addresses.  No mail is sent in this case.";
"Return {1, @actual_rcpts} if successful.";
{new_sender, new_rcpts, from, to, hdrs, body} = args;
if (typeof(hdrs) != LIST)
  hdrs = {hdrs, 0};
elseif (length(hdrs) < 2)
  hdrs = {@hdrs || {""}, 0};
endif
hdrs[3..2] = {{"Resent-By", this:name_list(new_sender)}, {"Resent-To", this:name_list(@new_rcpts)}};
if ($perm_utils:controls(caller_perms(), new_sender))
  text = $mail_agent:make_message(from, to, hdrs, body);
  return this:raw_send(text, new_rcpts, new_sender);
else
  return E_PERM;
endif
