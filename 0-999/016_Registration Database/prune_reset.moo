#16:prune_reset   this none this rxd

this:report_prune_progress();
player:tell("Resetting...");
this.prune_progress = "aaa";
this.prune_stop = "zzz";
this.total_pruned_people = 0;
this.total_pruned_characters = 0;
this.prune_task = 0;
