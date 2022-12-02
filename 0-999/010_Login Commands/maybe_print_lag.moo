#10:maybe_print_lag   this none this rxd

if (caller == this || caller_perms() == player)
  if (this.print_lag)
    lag = this:current_lag();
    if (lag > 1)
      lagstr = tostr("approximately ", lag, " seconds");
    elseif (lag == 1)
      lagstr = "approximately 1 second";
    else
      lagstr = "low";
    endif
    notify(player, tostr("The lag is ", lagstr, "; there ", (l = length(connected_players())) == 1 ? "is " | "are ", l, " connected."));
  endif
endif
