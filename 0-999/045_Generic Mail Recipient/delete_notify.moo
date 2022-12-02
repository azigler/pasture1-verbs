#45:delete_notify   this none this rxd

":delete_notify(recip[,recip...]) removes notifiees from this list.  Returns a list of results (E_PERM => not allowed, E_INVARG => not on list)";
if (caller == $mail_editor)
  perms = player;
else
  perms = caller_perms();
endif
result = {};
rmthis = 0;
for recip in (args)
  if (!(recip in this.mail_notify))
    r = E_INVARG;
  elseif (!valid(recip) || ($perm_utils:controls(perms, recip) || $perm_utils:controls(perms, this)))
    if (recip == this)
      rmthis = 1;
    endif
    this.mail_notify = setremove(this.mail_notify, recip);
    r = recip;
  else
    r = E_PERM;
  endif
  result = listappend(result, r);
endfor
return result;
