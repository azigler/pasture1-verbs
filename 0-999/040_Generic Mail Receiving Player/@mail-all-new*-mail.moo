#40:@mail-all-new*-mail   none none none rxd

"@mail-all-new-mail";
" Prints headers for all new mail on every mail-recipient mentioned in .current_message.";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
cm = this.current_message;
cm[1..2] = {{this, @cm[1..2]}};
this._mail_task = task_id();
nomail = 1;
new_cms = {};
for f in (cm)
  if (!($object_utils:isa(folder = f[1], $player) || $object_utils:isa(folder, $mail_recipient)))
    player:notify(tostr(folder, " is neither a $player nor a $mail_recipient"));
  elseif (typeof(flen = folder:length_all_msgs()) == ERR)
    player:notify(tostr($mail_agent:name(folder), " ", flen));
  elseif (msg_seq = $seq_utils:range(folder:length_date_le(f[3]) + 1, flen))
    nomail = 0;
    player:notify("===== " + $string_utils:left(tostr($mail_agent:name(folder), " (", s = $seq_utils:size(msg_seq), " message", s == 1 ? ") " | "s) "), 40, "="));
    folder:display_seq_headers(msg_seq, @f[2..3]);
    player:notify("");
    $command_utils:suspend_if_needed(2);
  endif
endfor
if (nomail)
  player:notify("You don't have any new mail anywhere.");
else
  player:notify("===== " + $string_utils:left("End of new mail ", 40, "="));
endif
