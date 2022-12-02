#10:maybe_limit_commands   this none this rxd

"This limits the number of commands that can be issued from the login prompt to prevent haywire login programs from lagging the MOO.";
"$login.current_numcommands has the number of commands they have issued at the prompt so far.";
"$login.max_numcommands has the maximum number of commands they may try before being booted.";
if (!caller_perms().wizard)
  return E_PERM;
else
  if (!(player in (keys = mapkeys(this.current_numcommands))))
    this.current_numcommands[player] = 1;
  else
    this.current_numcommands[player] = this.current_numcommands[player] + 1;
  endif
  "...sweep idle connections...";
  for p in (keys)
    if (typeof(`idle_seconds(p) ! ANY') == ERR)
      this.current_numcommands = mapdelete(this.current_numcommands, p);
    endif
  endfor
  if (this.current_numcommands[player] > this.max_numcommands)
    notify(player, "Sorry, too many commands issued without connecting.");
    boot_player(player);
    this.current_numcommands = mapdelete(this.current_numcommands, player);
    return 1;
  else
    return 0;
  endif
endif
