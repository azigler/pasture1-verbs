#25:report_prune_progress   this none this rxd

player:tell("Prune is up to ", toliteral(this.prune_progress), ".");
mine = 0;
if (typeof(this.prune_progress) == STR)
  alphalen = length(this.alphabet);
  total = alphalen * alphalen * alphalen;
  for x in [1..3]
    mine = mine * alphalen + index(this.alphabet, this.prune_progress[x]) - 1;
  endfor
else
  total = 256 * 256;
  mine = this.prune_progress[1] * 256 + this.prune_progress[2];
endif
percent = 100.0 * tofloat(mine) / tofloat(total);
player:tell("We have processed ", mine, " entries out of ", total, ", or ", toint(percent), ".", toint(10.0 * percent) % 10, "%.");
player:tell("There were ", this.total_pruned_people, " individual list entries removed, and ", this.total_pruned_sites, " whole sites removed.");
if ($code_utils:task_valid(this.prune_task))
  player:tell("Prune task is ", this.prune_task, ".  Stacktrace:");
  for x in (task_stack(this.prune_task, 1))
    if (valid(x[4]))
      player:tell(x[4], ":", x[2], " [", x[1], "]  ", x[3].name, "  (", x[6], ")");
    endif
  endfor
else
  player:tell("The recorded task_id is no longer valid.");
endif
