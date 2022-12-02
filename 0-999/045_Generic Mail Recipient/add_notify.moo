#45:add_notify   this none this rxd

":add_notify(recip[,recip...]) adds new notifiees to this list.  Returns a list of results (recip => success, E_PERM => not allowed, E_INVARG => not a valid recipient)";
if (caller == $mail_editor)
  perms = player;
else
  perms = caller_perms();
endif
result = {};
for recip in (args)
  if (!valid(recip) || recip == this)
    r = E_INVARG;
  elseif ($perm_utils:controls(perms, this) || (this:is_readable_by(perms) && $perm_utils:controls(perms, recip)))
    this.mail_notify = setadd(this.mail_notify, recip);
    r = recip;
  else
    r = E_PERM;
  endif
  result = listappend(result, r);
endfor
return result;
