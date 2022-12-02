#40:make_current_message   this none this rxd

":make_current_message(recipient[,index])";
"starts a new current_message record for recipient.";
"index, if given, indicates where recipient is to be";
"  placed (n = at or after nth entry in .current_message).";
recip = args[1];
cm = this.current_message;
if (length(args) > 1)
  i = max(2, min(args[2], length(cm)));
else
  i = 0;
endif
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  raise(E_PERM);
elseif (recip == this)
  "...self...";
elseif (j = $list_utils:iassoc(recip, cm))
  "...already present...";
  if (i)
    if (j < i)
      this.current_message = {@cm[1..j - 1], @cm[j + 1..i], cm[j], @cm[i + 1..$]};
    elseif (j > i + 1)
      this.current_message = {@cm[1..i], cm[j], @cm[i + 1..j - 1], @cm[j + 1..$]};
    endif
  endif
else
  this.current_message = listappend(cm, {recip, 0, 0}, @i ? {i} | {});
endif
