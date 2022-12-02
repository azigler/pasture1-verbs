#24:missed_help   this none this rxd

if (this.record_missed_help && callers()[1][4] == $player)
  miss = args[1];
  if (!(index = miss in this.missed_help_strings))
    this.missed_help_strings = {miss, @this.missed_help_strings};
    this.missed_help_counters = {{0, 0}, @this.missed_help_counters};
    index = 1;
  endif
  which = args[2] ? 2 | 1;
  this.missed_help_counters[index][which] = this.missed_help_counters[index][which] + 1;
endif
