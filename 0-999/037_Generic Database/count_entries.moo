#37:count_entries   this none this rxd

info = this.(" " + (prefix = args[1]));
count = length(info[3]) + args[2];
if (ticks_left() < 500 || seconds_left() < 2)
  player:tell("...", count);
  suspend(0);
endif
for i in [1..length(info[2])]
  count = this:count_entries(tostr(prefix, info[1], info[2][i]), count);
endfor
return count;
