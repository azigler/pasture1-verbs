#19:get_topic   this none this rxd

topic = args[1];
if (topic == "$" + topic[2..$ - 5] + "utils" && (valid(#0.(w = strsub(topic[2..$], "-", "_"))) && (uhelp = #0.(w):description())))
  return {tostr("General information on $", w, ":"), "----", @typeof(uhelp) == STR ? {uhelp} | uhelp};
else
  return pass(@args);
endif
