#79:init_for_core   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  pass(@args);
  this.exempted = {};
  this.working = #2;
  this.task_time_limit = 500;
  this.repeat_cycle = 0;
  this.large_objects = {};
  this.report_recipients = {#2};
  this.default_quota = {100000, 0, 0, 1};
  $quota_utils = this;
endif
