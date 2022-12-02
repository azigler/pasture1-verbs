#40:send_self_netmail   this none this rxd

":send_self_netmail(msg [ ,from ])";
"return 0 if successful, otherwise error.";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (error = $network:invalid_email_address($wiz_utils:get_email_address(this)))
  return "Invalid email address: " + error;
else
  msg = args[1];
  if (length(args) > 1)
    from = args[2];
    this:notify(tostr("Receiving mail from ", from:title(), " (", from, ") and forwarding it to your .email_address."));
  endif
  oplayer = player;
  player = this;
  error = $network:sendmail($wiz_utils:get_email_address(this), @msg);
  if (error && length(args) > 1)
    this:notify(tostr("Mail sending failed: ", error));
  endif
  player = oplayer;
  return error;
endif
