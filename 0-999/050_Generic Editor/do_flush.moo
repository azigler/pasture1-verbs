#50:do_flush   this none this rxd

"Flushes editor sessions older than args[1].  If args[2] is true, prints status as it runs.  If args[2] is false, runs silently.";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
else
  {t, noisy} = args;
  for i in [-length(this.active)..-1]
    if (this.times[-i] < t)
      if (noisy)
        player:tell($string_utils:nn(this.active[-i]), ctime(this.times[-i]));
      endif
      this:kill_session(-i);
    endif
  endfor
endif
