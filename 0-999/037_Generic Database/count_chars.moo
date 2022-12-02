#37:count_chars   this none this rxd

info = this.(" " + (prefix = args[1]));
count = args[2];
for s in (info[3])
  count = count + length(s);
endfor
if (ticks_left() < 500 || seconds_left() < 2)
  player:tell("...", count);
  suspend(0);
endif
for i in [1..length(info[2])]
  count = this:count_chars(tostr(prefix, info[1], info[2][i]), count);
endfor
return count;
