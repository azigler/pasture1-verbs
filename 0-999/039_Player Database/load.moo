#39:load   this none this rxd

":load() -- reloads the player_db with the names of all existing players.";
"This routine calls suspend() if it runs out of time.";
".frozen is set to 1 while the load is in progress so that other routines are warned and don't try to do any updates.  Sometimes, an update is unavoidable (e.g., player gets recycled) in which case the offending routine should set .frozen to 2, causing the load to start over at the beginning.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
"...N.B. clearall suspends, therefore we put the .frozen mark on FIRST...";
this.frozen = 1;
this:clearall();
for p in (players())
  this:suspend_restart(p);
  "... note that if a player is recycled or toaded during the suspension,...";
  "... it won't be removed from the for loop iteration; thus this test:     ";
  if (valid(p) && is_player(p))
    if (typeof(po = this:find_exact(p.name)) == ERR)
      player:tell(p.name, ":  ", po);
      return;
    elseif (po != p)
      if (valid(po) && is_player(po))
        player:tell("name `", p.name, "' for ", p, " subsumes alias for ", po.name, "(", po, ").");
      endif
      this:insert(p.name, p);
    endif
    for a in (p.aliases)
      this:suspend_restart(p);
      if (index(a, " ") || index(a, "	"))
        "don't bother, space or tab";
      elseif (typeof(ao = this:find_exact(a)) == ERR)
        player:tell(a, ":  ", ao);
        return;
      elseif (!(valid(ao) && is_player(ao)))
        this:insert(a, p);
      elseif (ao != p)
        player:tell("alias `", a, "' for ", p.name, "(", p, ") used by ", ao.name, "(", ao, ").");
      endif
    endfor
  endif
endfor
this.frozen = 0;
