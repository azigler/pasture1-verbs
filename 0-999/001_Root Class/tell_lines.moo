#1:tell_lines   this none this rxd

lines = args[1];
if (typeof(lines) == LIST)
  for line in (lines)
    this:tell(line);
  endfor
else
  this:tell(lines);
endif
