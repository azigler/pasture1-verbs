#45:delete_forward   this none this rxd

":delete_forward(recip[,recip...]) removes recipients to this list.  Returns a list of results (E_PERM => not allowed, E_INVARG => not on list)";
if (caller == $mail_editor)
  perms = player;
else
  perms = caller_perms();
endif
result = {};
forward_self = !this.mail_forward || this in this.mail_forward;
for recip in (args)
  if (!(recip in this.mail_forward))
    r = E_INVARG;
  elseif (!valid(recip) || $perm_utils:controls(perms, recip) || $perm_utils:controls(perms, this))
    if (recip == this)
      forward_self = 0;
    endif
    this.mail_forward = setremove(this.mail_forward, recip);
    r = recip;
  else
    r = E_PERM;
  endif
  result = listappend(result, r);
endfor
if (!(forward_self || this.mail_forward))
  this.mail_forward = {$nothing};
elseif (this.mail_forward == {this})
  this.mail_forward = {};
endif
return result;
