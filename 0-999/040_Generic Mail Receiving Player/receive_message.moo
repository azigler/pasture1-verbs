#40:receive_message   this none this rxd

":receive_message(msg,from)";
if (!$perm_utils:controls(caller_perms(), this) && caller != this)
  return E_PERM;
endif
if (this:mail_option("no_dupcc", args[1][1], args[1][2]))
  "pass to :mail_option the TEXT versions of who the message is from and to";
  recipients = setremove($mail_agent:parse_address_field(args[1][3]), this);
  for x in (recipients)
    if (this:get_current_message(x))
      return 0;
    endif
  endfor
endif
if (this:mail_option("netmail"))
  msg = args[1];
  message = {"Forwarded: " + msg[4], "Original-date: " + ctime(msg[1]), "Original-From: " + msg[2], "Original-To: " + msg[3], "Reply-To: " + $string_utils:substitute(args[2].name, {{"@", "%"}}) + "@" + $network.moo_name + ".moo.mud.org"};
  for x in (msg[5..$])
    message = {@message, @$generic_editor:fill_string(x, this:linelen())};
  endfor
  if (this:send_self_netmail(message, @listdelete(args, 1)) == 0)
    return 0;
  endif
endif
set_task_perms(this.owner);
new = this:new_message_num();
ncur = new <= 1 ? 0 | min(this:current_message(this), new);
this:set_current_message(this, ncur);
new = max(new, ncur + 1);
this.messages = {@this.messages, {new, args[1]}};
"... new-mail notification is now done directly by $mail_agent:raw_send";
"... see :notify_mail...";
return new;
