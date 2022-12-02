#65:show_sticky   this none this rxd

value = this:get(@args);
if (value)
  return {value, {"Sticky folders:  mail commands default to whatever", "mail collection the previous successful command looked at."}};
else
  return {0, {"Teflon folders:  mail commands always default to `on me'."}};
endif
