#6:tell_contents   this none this rxd

c = args[1];
if (c)
  longear = {};
  gear = {};
  width = player:linelen();
  half = width / 2;
  player:tell("Carrying:");
  for thing in (c)
    cx = tostr(" ", thing:title());
    if (length(cx) > half)
      longear = {@longear, cx};
    else
      gear = {@gear, cx};
    endif
  endfor
  player:tell_lines($string_utils:columnize(gear, 2, width));
  player:tell_lines(longear);
endif
