#40:@netforw*ard   any any any rxd

"@netforward <msg>...                  -- as in help on @netforward";
"@netforward <msg>... on *<recipient>  -- netforwards messages on recipient.";
"This command forwards mail-messages to your registered email-address.";
if (player != this)
  return player:tell(E_PERM);
endif
if (reason = $network:email_will_fail(email = $wiz_utils:get_email_address(player)))
  return player:notify(tostr("Cannot forward mail to your email address: ", reason));
endif
set_task_perms(valid(cp = caller_perms()) ? cp | player);
if (p = player:parse_mailread_cmd(verb, args, "", "on"))
  player:set_current_folder(folder = p[1]);
  msg_seq = p[2];
  folderstr = folder == player ? "" | tostr(" from ", $mail_agent:name(folder));
  if (!this:mail_option("expert_netfwd") && !$command_utils:yes_or_no(tostr("You are about to forward ", seq_size = $seq_utils:size(msg_seq), " message(s)", folderstr, " to your registered email-address, ", email, ".  Continue?")))
    player:notify(tostr("@Netforward cancelled."));
    return;
  endif
  player:notify("Attempting to send network mail...");
  player._mail_task = task_id();
  multiple_vals = this:format_for_netforward(folder:messages_in_seq(msg_seq), folderstr);
  netmail = multiple_vals[1];
  header = multiple_vals[2];
  reason = player:send_self_netmail({header, @netmail});
  player:notify(reason == 0 ? tostr("@netforward of ", header, " completed.") | tostr("@netforward failed: ", reason, "."));
endif
