#71:move_em   this none this rxd

if (caller == this)
  {who, dest} = args;
  set_task_perms(who);
  fork (0)
    fork (0)
      "This is forked so that it's protected from aborts due to errors in the player's :moveto verb.";
      if (who.location != dest)
        "Unfortunately, if who is -already- at $player_start, move() won't call :enterfunc and the sleeping body never goes to $limbo. Have to call explicitly for that case. Ho_Yan 11/2/95";
        if (who.location == $player_start)
          $player_start:enterfunc(who);
        else
          "Nosredna, 5/4/01: but wait, why don't we just moved them straight to limbo?";
          move(who, $limbo);
        endif
      endif
    endfork
    start = who.location;
    this:set_moveto_task();
    who:moveto(dest);
    if (who.location != start)
      start:announce(this:take_away_msg(who));
    endif
    if (who.location == dest)
      dest:announce(this:drop_off_msg(who));
    endif
  endfork
else
  return E_PERM;
endif
