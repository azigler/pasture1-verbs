#25:prune_numeric   this none this rxd

"Carefully loop through the db and delete items associated with !valid and !is_player objects.  If that results in no objects remaining for a site, delete that site.";
"Attempt to keep memory usage down by only asking for a small number of items at a time.  Should probably have some arguments to control this.";
"Another thing it should do is be clever about string typed items.";
"Rewriting this to do numerics now.";
if (!caller_perms().wizard)
  raise(E_PERM);
endif
this.prune_task = task_id();
probe = this.prune_progress;
while (probe[1] <= this.prune_stop)
  probestring = tostr(probe[1], ".", probe[2], ".");
  for sitename in (z = this:find_all_keys(probestring))
    items = this:find_exact(sitename);
    orig = items;
    for y in (items)
      if (typeof(y) == OBJ && (!valid(y) || !is_player(y)))
        items = setremove(items, y);
      endif
      $command_utils:suspend_if_needed(0);
    endfor
    if (!items)
      this:delete(sitename);
      this.total_pruned_sites = this.total_pruned_sites + 1;
    elseif (items == orig)
    else
      this:insert(sitename, items);
      this.total_pruned_people = this.total_pruned_people + length(orig) - length(items);
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  if (probe[2] == 255)
    probe[1] = probe[1] + 1;
    probe[2] = 0;
  else
    probe[2] = probe[2] + 1;
  endif
  this.prune_progress = probe;
  if ($command_utils:running_out_of_time())
    set_task_perms($wiz_utils:random_wizard());
    suspend(0);
  endif
endwhile
player:tell("Prune stopped at ", toliteral(this.prune_progress));
