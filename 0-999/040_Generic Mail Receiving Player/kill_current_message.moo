#40:kill_current_message   this none this rxd

":kill_current_message(recipient)";
"entirely forgets current message for this recipient...";
"Returns true iff successful.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  raise(E_PERM);
else
  return (recip = args[1]) != this && ((i = $list_utils:iassoc(recip, cm = this.current_message)) && (this.current_message = listdelete(cm, i)));
endif
