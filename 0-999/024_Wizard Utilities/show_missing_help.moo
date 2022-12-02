#24:show_missing_help   this none this rxd

mhs = this.missed_help_strings;
cnt = this.missed_help_counters;
"save values first, so subsequent changes during suspends wont affect it";
thresh = args ? args[1] | 5;
strs = {};
for i in [1..length(mhs)]
  $command_utils:suspend_if_needed(0);
  if (cnt[i][1] + cnt[i][2] > thresh)
    strs = {@strs, $string_utils:right(tostr(cnt[i][1]), 5) + " " + $string_utils:right(tostr(cnt[i][2]), 5) + " " + mhs[i]};
  endif
endfor
sorted = $list_utils:sort_suspended(0, strs);
len = length(sorted);
player:tell(" miss ambig word");
for x in [1..len]
  $command_utils:suspend_if_needed(0);
  player:tell(sorted[len - x + 1]);
endfor
player:tell(" - - - - - - - - -");
