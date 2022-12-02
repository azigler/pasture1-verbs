#102:actual   this none this rxd

if (args[1] == "all")
  return {{"colors", a = args[2]}, {"backgrounds", a}, {"extra", a}, {"misc", a}, {"blinking", a}, {"bold", a}, {"ignore", 0}, {"truecolor", a}, {"256", a}};
elseif (args[1] == "none")
  return {{"colors", a = !args[2]}, {"backgrounds", a}, {"extra", a}, {"misc", a}, {"blinking", a}, {"bold", a}, {"truecolor", a}, {"256", a}};
else
  return {args};
endif
