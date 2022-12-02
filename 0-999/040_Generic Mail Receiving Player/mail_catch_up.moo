#40:mail_catch_up   this none this rxd

set_task_perms(caller == this ? this.owner | caller_perms());
this:set_current_folder(this);
dates = new_cm = head = {};
sort = this:mail_option("rn_order") || "read";
for n in (this.current_message)
  $command_utils:suspend_if_needed(0);
  if (typeof(n) != LIST)
    head = {@head, n};
  elseif ($object_utils:isa(folder = n[1], $mail_recipient) && folder:is_readable_by(this))
    "...set current msg to be the last one you could possibly have read.";
    if (n[3] < folder.last_msg_date)
      i = folder:length_date_le(n[3]);
      n[2] = i && folder:messages_in_seq(i)[1];
    endif
    if (sort == "fixed")
      new_cm = {n, @new_cm};
    elseif (sort == "send")
      j = $list_utils:find_insert(dates, folder.last_msg_date - 1);
      dates = listinsert(dates, folder.last_msg_date, j);
      new_cm = listinsert(new_cm, n, j);
    else
      new_cm = listappend(new_cm, n, $list_utils:iassoc_sorted(n[3] - 1, new_cm, 3));
    endif
  endif
endfor
this.current_message = {@head, @$list_utils:reverse(new_cm)};
