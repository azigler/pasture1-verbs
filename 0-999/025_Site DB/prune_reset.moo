#25:prune_reset   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
this:report_prune_progress();
player:tell("Resetting...");
this.total_pruned_sites = 0;
this.total_pruned_people = 0;
this.prune_progress = "aaa";
this.prune_stop = "zzz";
`kill_task(this.prune_task) ! ANY';
