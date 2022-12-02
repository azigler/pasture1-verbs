#16:prune   this none this rxd

"Carefully loop through the db and delete items associated with reaped objects.  If that results in no objects remaining for a username, delete that username.";
"Attempt to keep memory usage down by only asking for a small number of items at a time.  Should probably have some arguments to control this.";
if (!caller_perms().wizard)
  raise(E_PERM);
endif
this.prune_task = task_id();
probe = this.prune_progress;
while (probe < this.prune_stop)
  for username in (this:find_all_keys(probe))
    items = this:find_exact(username);
    orig = items;
    for y in (items)
      {who, @whys} = y;
      if (!valid(who) || !is_player(who))
        nuke = 1;
        for why in (whys)
          if (why && why != "zapped due to inactivity" && why != "toaded due to inactivity" && why != "Additional email address")
            nuke = 0;
          endif
        endfor
        if (nuke)
          items = setremove(items, y);
        endif
      endif
      $command_utils:suspend_if_needed(0);
    endfor
    if (!items)
      this:delete(username);
      this.total_pruned_people = this.total_pruned_people + 1;
    elseif (items != orig)
      this:insert(username, items);
      this.total_pruned_characters = this.total_pruned_characters + length(orig) - length(items);
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  probe = $string_utils:incr_alpha(probe, this.alphabet);
  this.prune_progress = probe;
  if ($command_utils:running_out_of_time())
    set_task_perms($wiz_utils:random_wizard());
    suspend(0);
  endif
endwhile
player:tell("Prune stopped at ", toliteral(this.prune_progress));
