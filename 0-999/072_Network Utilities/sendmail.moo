#72:sendmail   any none none rxd

"sendmail(to, subject, line1, line2, ...)";
"  sends mail to internet address 'to', with given subject.";
"  It fills in various fields, such as date, from (from player), etc.";
"  the rest of the arguments are remaining lines of the message, and may begin with additional header fields.";
"  (must match RFC822 specification).";
"Requires $network.trust to call (no anonymous mail from MOO).";
"Returns 0 if successful, or else error condition or string saying why not.";
if (!this:trust(caller_perms()))
  return E_PERM;
endif
mooname = this.MOO_name;
mooinfo = tostr(mooname, " (", this.site, " ", this.port, ")");
if (reason = this:invalid_email_address(to = args[1]))
  return reason;
endif
"took out Envelope-from:  + this.errors_to_address";
tries = 4;
result = "unknown";
while (tries > 0 && result != 0)
  tries = tries - 1;
  result = this:raw_sendmail(to, "Date: " + $time_utils:rfc822_ctime(), "From: " + this:return_address_for(player), "To: " + to, "Subject: " + args[2], "Errors-to: " + this.errors_to_address, "X-Mail-Agent: " + mooinfo, @args[3..$]);
endwhile
return result;
