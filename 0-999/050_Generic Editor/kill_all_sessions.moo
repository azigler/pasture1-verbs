#50:kill_all_sessions   this none this rxd

"WIZARDLY";
if (caller != this && !caller_perms().wizard)
  return E_PERM;
else
  for victim in (this.contents)
    victim:tell("Sorry, ", this.name, " is going down.  Your editing session is hosed.");
    victim:moveto((who = victim in this.active) && valid(origin = this.original[who]) ? origin | (valid(victim.home) ? victim.home | $player_start));
  endfor
  for p in ({@this.stateprops, {"original"}, {"active"}, {"times"}})
    this.(p[1]) = {};
  endfor
  return 1;
endif
