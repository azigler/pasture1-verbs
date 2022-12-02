#7:defaulting_oleave_msg   this none this rxd

for k in ({this.name, @this.aliases})
  if (k in {"east", "west", "south", "north", "northeast", "southeast", "southwest", "northwest", "out", "up", "down", "nw", "sw", "ne", "se", "in"})
    return "goes " + k + ".";
  elseif (k in {"leave", "out", "exit"})
    return "leaves";
  endif
endfor
if (index(this.name, "an ") == 1 || index(this.name, "a ") == 1)
  return "leaves for " + this.name + ".";
else
  return "leaves for the " + this.name + ".";
endif
