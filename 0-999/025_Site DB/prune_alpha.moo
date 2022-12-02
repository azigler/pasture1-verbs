#25:prune_alpha   this none this rxd

"Carefully loop through the db and delete items associated with !valid and !is_player objects.  If that results in no objects remaining for a site, delete that site.";
"Attempt to keep memory usage down by only asking for a small number of items at a time.  Should probably have some arguments to control this.";
"Another thing it should do is be clever about string typed items.  (What did I mean by this?)";
"New feature: If the site name contains `dialup', then, if none of the users who have connected from there still have it in their .all_connect_places, then consider it trashable.  Maybe this will get some space savings.";
"To run: call $site_db:prune_reset() then $site_db:prune_alpha().";
"or $site_db:prune_alpha(1) for verbose output";
verbose = args && args[1];
if (!caller_perms().wizard)
  raise(E_PERM);
endif
this.prune_task = task_id();
probe = this.prune_progress;
while (probe <= this.prune_stop && length(probe) == length(this.prune_stop))
  for sitename in (z = this:find_all_keys(probe))
    items = this:find_exact(sitename);
    orig = items;
    dialup = index(sitename, "dialup");
    "Don't keep around dialups.";
    for y in (items)
      if (typeof(y) == OBJ && (!valid(y) || !is_player(y) || (dialup && !(sitename in y.all_connect_places))))
        verbose && player:tell("removing ", $string_utils:nn(y), " from ", sitename);
        items = setremove(items, y);
      endif
      $command_utils:suspend_if_needed(0);
    endfor
    useless = 1;
    "If no player has this site in eir .all_connect_places, nuke it anyway.";
    for y in (items)
      if (typeof(y) != OBJ || sitename in y.all_connect_places)
        useless = 0;
        break;
        "unfortunately this can get kinna O(n^2).";
      endif
      $command_utils:suspend_if_needed(0);
    endfor
    if (useless)
      verbose && player:tell(sitename, " declared useless and nuked");
      items = {};
    endif
    if (!items)
      this:delete(sitename);
      this.total_pruned_sites = this.total_pruned_sites + 1;
    elseif (items == orig)
    else
      this:insert(sitename, items);
      this.total_pruned_people = this.total_pruned_people + length(orig) - length(items);
    endif
    $command_utils:suspend_if_needed(0);
    if (probe >= this.prune_stop)
      return player:tell("Prune stopped at ", toliteral(this.prune_progress));
    endif
  endfor
  probe = $string_utils:incr_alpha(probe, this.alphabet);
  this.prune_progress = probe;
  if ($command_utils:running_out_of_time())
    set_task_perms($wiz_utils:random_wizard());
    suspend(0);
  endif
endwhile
player:tell("Prune stopped at ", toliteral(this.prune_progress));
