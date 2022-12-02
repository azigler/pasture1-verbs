#46:send_message   this none this rxd

"send_message(from,rcpt-list,hdrs,msg) -- formats and sends a mail message.  hders is either the text of the subject line, or a {subject,{reply-to,...}} list.";
"Return E_PERM if from isn't owned by the caller.";
"Return {0, @invalid_rcpts} if rcpt-list contains any invalid addresses.  No mail is sent in this case.";
"Return {1, @actual_rcpts} if successful.";
{from, to, orig_hdrs, msg} = args;
"...";
"... remove bogus Resent-To/Resent-By headers...";
"...";
if (typeof(orig_hdrs) == LIST && length(orig_hdrs) > 2)
  hdrs = orig_hdrs[1..2];
  orig_hdrs[1..2] = {};
  strip = {"Resent-To", "Resent-By"};
  for h in (orig_hdrs)
    h[1] in strip || (hdrs = {@hdrs, h});
  endfor
else
  hdrs = orig_hdrs;
endif
"...";
"... send it...";
"...";
if ($perm_utils:controls(caller_perms(), from))
  text = $mail_agent:make_message(from, to, hdrs, msg);
  return this:raw_send(text, to, from);
else
  return E_PERM;
endif
