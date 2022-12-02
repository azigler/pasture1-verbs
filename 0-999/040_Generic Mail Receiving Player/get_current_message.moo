#40:get_current_message   this none this rxd

":get_current_message([recipient])";
" => {msg_num, last_read_date} for the given recipient.";
" => 0 if we have no record of that recipient.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  raise(E_PERM);
elseif (!args || args[1] == this)
  if (length(this.current_message) < 2)
    "Whoops, this got trashed---fix it up!";
    this.current_message = {0, time(), @this.current_message};
  endif
  return this.current_message[1..2];
elseif (a = $list_utils:assoc(args[1], this.current_message))
  return a[2..3];
else
  return 0;
endif
