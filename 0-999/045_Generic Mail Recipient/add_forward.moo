#45:add_forward   this none this rxd

":add_forward(recip[,recip...]) adds new recipients to this list.  Returns a string error message or a list of results (recip => success, E_PERM => not allowed, E_INVARG => not a valid recipient, string => other kind of failure)";
if (caller == $mail_editor)
  perms = player;
else
  perms = caller_perms();
endif
result = {};
forward_self = !this.mail_forward || this in this.mail_forward;
for recip in (args)
  if (!valid(recip) || (!is_player(recip) && !($mail_recipient in $object_utils:ancestors(recip))))
    r = E_INVARG;
  elseif ($perm_utils:controls(perms, this) || (typeof(this.readers) != LIST && $perm_utils:controls(perms, recip)))
    this.mail_forward = setadd(this.mail_forward, recip);
    r = recip;
  else
    r = E_PERM;
  endif
  result = listappend(result, r);
endfor
if (length(this.mail_forward) > 1 && $nothing in this.mail_forward)
  this.mail_forward = setremove(this.mail_forward, $nothing);
endif
if (forward_self)
  this.mail_forward = setadd(this.mail_forward, this);
endif
return result;
