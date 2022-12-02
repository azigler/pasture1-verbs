#47:local_editing_info   this none this rxd

lines = {"To:       " + (toline = $mail_agent:name_list(@args[1])), "Subject:  " + $string_utils:trim(subject = args[2])};
if (args[3])
  lines = {@lines, "Reply-to: " + $mail_agent:name_list(@args[3])};
endif
lines = {@lines, "", @args[4]};
return {tostr("MOOMail", subject ? "(" + subject + ")" | "-to(" + toline + ")"), lines, "@@sendmail", "sendmail", "string-list"};
