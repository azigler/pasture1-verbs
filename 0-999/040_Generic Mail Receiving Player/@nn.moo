#40:@nn   none none none rxd

"@nn  -- reads the first new message on the first mail_recipient (in .current_message) where new mail exists.";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
cm = this.current_message;
cm[1..2] = {{this, @cm[1..2]}};
for n in (cm)
  if ($mail_agent:is_recipient(n[1]))
    if (new = n[1]:length_date_gt(n[3]))
      next = n[1]:length_all_msgs() - new + 1;
      this:set_current_folder(folder = n[1]);
      this._mail_task = task_id();
      cur = folder:display_seq_full({next, next + 1}, tostr("Message %d", " on ", $mail_agent:name(folder), ":"));
      this:set_current_message(folder, @cur);
      return;
    endif
  else
    player:notify(tostr("Bogus recipient ", n[1], " removed from .current_message."));
    this.current_message = setremove(this.current_message, n);
  endif
endfor
player:tell("No News (is good news)");
