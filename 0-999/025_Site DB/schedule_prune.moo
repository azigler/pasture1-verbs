#25:schedule_prune   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
day = 24 * 3600;
hour_of_day_GMT = 9;
target = hour_of_day_GMT * 60 * 60 + day - time() % day;
if (target > 86400)
  target = target - 86400;
endif
fork (target)
  "Stop at 2am before checkpoint.";
  if ($code_utils:task_valid(this.prune_task))
    $site_db.prune_stop = "aaa";
    "Restart after 3am.  Er, 4am.";
    suspend(7500);
    this:schedule_prune();
    $site_db.prune_stop = "zzz";
    "Just in case it didn't actually stop...";
    if (!$code_utils:task_valid(this.prune_task))
      $site_db:prune_alpha();
    endif
  endif
endfork
