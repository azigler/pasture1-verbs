#65:check_netmail   this none this rxd

":check_netmail(value) => Makes sure the email-address is one that can actually be used by $network:sendmail().";
"The actual value sent is not checked since it can only be a boolean flag.  The player's email_address property is what is checked.";
"Possible situations where the address would be unusable are when the address is invalid or we can't connect to the site to send mail.";
"Returns a string error message if unusable or {value} otherwise.";
if (caller != this)
  return E_PERM;
endif
if (args[1] && (reason = $network:email_will_fail($wiz_utils:get_email_address(player))))
  return tostr("Invalid registered email_address: ", reason);
endif
return args;
