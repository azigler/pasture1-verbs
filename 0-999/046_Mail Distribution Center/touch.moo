#46:touch   this none this rxd

"touch(name or list,seen) => does .last_used_time = time() if we haven't already touched this in the last hour";
{recip, ?seen = {}} = args;
if (typeof(recip) == LIST)
  for r in (recip)
    result = this:touch(r, seen);
    $command_utils:suspend_if_needed(0);
  endfor
else
  if (!valid(recip) || recip in seen || (!is_player(recip) && !($mail_recipient in $object_utils:ancestors(recip))))
    "recip is neither a player nor a mailing list/folder";
  else
    if (fwd = this:mail_forward(recip))
      this:touch(fwd, {@seen, recip});
    endif
    if (!is_player(recip))
      recip.last_used_time = time();
    endif
  endif
endif
