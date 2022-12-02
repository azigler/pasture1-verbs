#6:tell   this none this rxd

if (this.gaglist || this.paranoid)
  "Check the above first, default case, to save ticks.  Paranoid gaggers are cost an extra three or so ticks by this, probably a net savings.";
  if (this:gag_p())
    return;
  endif
  if (this.paranoid == 1)
    $paranoid_db:add_data(this, {{@callers(1), {player, "<cmd-line>", player}}, args});
  elseif (this.paranoid == 2)
    z = this:whodunnit({@callers(), {player, "", player}}, {this, $no_one}, {})[3];
    args = {"(", z.name, " ", z, ") ", @args};
  endif
endif
pass(@args);
