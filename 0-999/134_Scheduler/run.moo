#134:run   this none this rxd

":run(): Start the scheduler loops.";
!caller_perms().wizard && raise(E_PERM);
res = 0;
if (this:cron_loop())
  res = 1;
endif
if (this:timer_loop())
  res = 1;
endif
return res;
"Last modified Fri Sep  8 07:22:16 2017 CDT by Jason Perino (#91@ThetaCore).";
