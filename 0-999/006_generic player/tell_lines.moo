#6:tell_lines   this none this rxd

lines = args[1];
if (typeof(lines) != LIST)
  lines = {lines};
endif
if (this.gaglist || this.paranoid)
  "Check the above first, default case, to save ticks.  Paranoid gaggers are cost an extra three or so ticks by this, probably a net savings.";
  if (this:gag_p())
    return;
  endif
  if (this.paranoid == 2)
    z = this:whodunnit({@callers(1), {player, "", player}}, {this, $no_one}, {})[3];
    lines = {"[start text by " + z.name + " (" + tostr(z) + ")]", @lines, "[end text by " + z.name + " (" + tostr(z) + ")]"};
  elseif (this.paranoid == 1)
    $paranoid_db:add_data(this, {{@callers(1), {player, "<cmd-line>", player}}, lines});
  endif
endif
this:notify_lines(lines);
