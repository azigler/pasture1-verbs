#40:current_message   this none this rxd

":current_message([recipient])";
" => current message number for the given recipient (defaults to this).";
" => 0 if we have no record of that recipient";
"      or current message happens to be 0.";
"This verb is mostly obsolete; consider using :get_current_message()";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  raise(E_PERM);
elseif (!args || args[1] == this)
  return this.current_message[1];
elseif (a = $list_utils:assoc(args[1], this.current_message))
  return a[2];
else
  return 0;
endif
