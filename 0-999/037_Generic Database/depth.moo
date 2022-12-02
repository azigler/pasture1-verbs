#37:depth   this none this rxd

info = this.(" " + (prefix = (args || {""})[1]));
depth = 0;
string = prefix;
if (ticks_left() < 500 || seconds_left() < 2)
  player:tell("...", prefix);
  suspend(0);
endif
for i in [1..length(info[2])]
  if ((r = this:depth(tostr(prefix, info[1], info[2][i])))[1] > depth)
    depth = r[1];
    string = r[2];
  endif
endfor
return {depth + 1, string};
