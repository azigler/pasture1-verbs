#71:move_players_home   this none this rxd

if (!$perm_utils:controls(caller_perms(), this))
  "perms don't control the $housekeeper; probably not called by $room:disfunc then. Used to let args[1] call this. No longer.";
  return E_PERM;
endif
this.player_queue = {@this.player_queue, {args[1], time() + 300}};
if ($code_utils:task_valid(this.move_player_task))
  "the move-players-home task is already running";
  return;
endif
fork tid (10)
  while (this.player_queue)
    if ((mtime = this.player_queue[1][2]) < time() + 10)
      who = this.player_queue[1][1];
      "Remove from queue first so that if they do something malicious, like put a kill_task in a custom :accept_for_abode, they won't be in the queue when the task restarts with the next player disconnect. Ho_Yan 12/3/98";
      this.player_queue = listdelete(this.player_queue, 1);
      if (is_player(who) && !$object_utils:connected(who))
        dest = `who.home:accept_for_abode(who) ! ANY => 0' ? who.home | $player_start;
        if (who.location != dest)
          player = who;
          this:move_em(who, dest);
        endif
      endif
    else
      suspend(mtime - time());
    endif
    $command_utils:suspend_if_needed(1);
  endwhile
endfork
this.move_player_task = tid;
