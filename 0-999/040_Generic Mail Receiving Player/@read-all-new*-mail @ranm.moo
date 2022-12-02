#40:"@read-all-new*-mail @ranm"   any none none rxd

"@read-all-new-mail [yes]";
" Prints all new mail on every mail-recipient mentioned in .current_message";
" Generally this will spam you into next Tuesday.";
" You will be queried for whether you want your last-read dates updated";
"   but you can specify \"yes\" on the command line to suppress this.";
"   If you do so, last-read dates will be updated after each folder read.";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
noconfirm = args && args[1];
if (noconfirm && noconfirm != "yes" && noconfirm != "no")
  player:notify("Unexpected argument(s): " + argstr);
  return;
endif
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
    player:notify("");
    if (cur = folder:display_seq_full(msg_seq, tostr("Message %d", folder == this ? "" | " on " + $mail_agent:name(folder), ":")))
      if (noconfirm == "yes")
        this:set_current_message(folder, @cur);
        this:set_current_folder(folder);
      else
        new_cms = {@new_cms, {folder, @cur}};
      endif
      player:notify("");
    endif
  endif
  $command_utils:suspend_if_needed(1);
  this._mail_task = task_id();
endfor
if (nomail)
  player:notify("You don't have any new mail anywhere.");
elseif (player:notify("===== " + $string_utils:left("End of new mail ", 40, "=")) || (noconfirm ? noconfirm == "yes" | $command_utils:yes_or_no("Did you get all of that?")))
  for n in (new_cms)
    this:set_current_message(@n);
    this:set_current_folder(n[1]);
  endfor
  player:notify("Last-read-dates updated");
else
  player:notify("Last-read-dates not updated");
endif
