#134:init_for_core   this none this xd

!caller_perms().wizard && raise(E_PERM);
this.cron_tasks = this.special_cron_tasks = this.timer_tasks = {};
special_cron_tasks = {{"hourly", 0, 0, -1, -1, -1, -1, #-1, #-1, "_cron_hourly", {}}, {"daily", 0, 0, 0, -1, -1, -1, #-1, #-1, "_cron_daily", {}}, {"weekly", 0, 0, 0, -1, -1, 0, #-1, #-1, "_cron_weekly", {}}, {"monthly", 0, 0, 0, 1, -1, -1, #-1, #-1, "_cron_monthly", {}}, {"quarterly", 0, 0, 0, 1, -3, -1, #-1, #-1, "_cron_quarterly", {}}, {"semiannually", 0, 0, 0, 1, -6, -1, #-1, #-1, "_cron_semiannually", {}}, {"annually", 0, 0, 0, 1, 1, -1, #-1, #-1, "_cron_annually", {}}};
for s in (special_cron_tasks)
  if ($object_utils:has_callable_verb(this, s[10]))
    this.special_cron_tasks = {@this.special_cron_tasks, s[10]};
    set_verb_code(this, s[10], $code_utils:verb_documentation(this, s[10]));
  endif
endfor
"Last modified Mon Mar 12 08:15:02 2018 CDT by Jason Perino (#91@ThetaCore).";
