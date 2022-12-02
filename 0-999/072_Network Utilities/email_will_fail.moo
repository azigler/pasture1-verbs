#72:email_will_fail   this none this rxd

":email_will_fail(email-address[, display?]) => Makes sure the email-address is one that can actually be used by $network:sendmail().";
{email, ?display = 0} = args;
reason = this:invalid_email_address(email);
if (reason && display)
  player:tell("Invalid email address: ", reason);
endif
return reason;
"following is code from OpalMOO, not used here";
"Possible situations where the address would be unusable are when the address is invalid or we can't connect to the site to send mail.";
"If <display> is true, error messages are displayed to the player and 1 is returned when address is unuable.  If <display> is false and address is unusable, the error message is returned.  If the address is usable, 0 is always returned.";
if (!this:approved_for_network(caller_perms()))
  return E_PERM;
endif
if (!this:valid_email_address(email))
  msg = tostr("Your email address (", email, ") is not a usable account.");
elseif ((result = this:verify_email_address(email)) == E_INVARG)
  msg = tostr("Unable to connect to ", this:parse_address(email)[2], ".");
elseif (typeof(result) == STR)
  msg = tostr("The site ", (parse = this:parse_address(email))[2], " does not recognize ", parse[1], " as a valid account.");
else
  return 0;
endif
if (display)
  player:tell(msg);
  return 1;
else
  return msg;
endif
"Last modified Tue Jun 15 00:19:01 1993 EDT by Ranma (#200).";
