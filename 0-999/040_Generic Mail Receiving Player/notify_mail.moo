#40:notify_mail   this none this rxd

":notify_mail(from,recipients[,msgnums])";
" used by $mail_agent:raw_send to notify this player about mail being sent";
" from <from> to <recipients>.  <msgnums> if given gives the message number(s) assigned (in the event that the corresponding recipient actually kept the mail)";
if (!$object_utils:connected(this))
  return;
elseif (!(caller in {this, $mail_agent} || $perm_utils:controls(caller_perms(), this)))
  return E_PERM;
else
  {from, recipients, ?msgnums = {}} = args;
  from_name = $mail_agent:name(from);
  "... msgnums may be shorter than recipients or may have some slots filled";
  "... with 0's if msg numbers are not available for some recipients.";
  if ((t = this in recipients) && (length(msgnums) >= t && msgnums[t]))
    "... you are getting the mail and moreover your :receive_message kept it.";
    namelist = $string_utils:english_list($list_utils:map_arg($mail_agent, "name", setremove(recipients, this)), "");
    this:notify(tostr("You have new mail (", msgnums[t], ") from ", from_name, namelist ? " which was also sent to " + namelist | "", "."));
    if (!this:mail_option("expert"))
      this:notify(tostr("Type `help mail' for info on reading it."));
    endif
  else
    "... vanilla notification; somebody got sent mail and you're finding out.";
    namelist = $string_utils:english_list({@t ? {"You"} | {}, @$list_utils:map_arg($mail_agent, "name", setremove(recipients, this))}, "");
    this:tell(tostr(namelist, length(recipients) == 1 ? " has" | " have", " just been sent new mail by ", from_name, "."));
  endif
endif
