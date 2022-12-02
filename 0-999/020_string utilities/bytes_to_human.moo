#20:bytes_to_human   this none this rxd

":bytes_to_human(INT <bytes>, ?INT <round>) => STR";
"Returns a string with <bytes> converted to the highest possible unit of measurement. e.g. KiB, MiB, GiB, TiB, etc.";
"If <round> is true, the value will be rounded to the nearest hundredths. Rounding is used by default.";
{bytes, ?round = 1} = args;
if (!(typeof(bytes) in {INT, FLOAT}))
  raise(E_INVARG, "Bytes must be an integer or a float.");
endif
bytes = tofloat(bytes);
abs_bytes = abs(bytes);
if (abs_bytes < 1024.0)
  unit = "bytes";
elseif (abs_bytes < 1024.0 ^ 2)
  unit = "KB";
elseif (abs_bytes < 1024.0 ^ 3)
  unit = "MB";
elseif (abs_bytes < 1024.0 ^ 4)
  unit = "GB";
elseif (abs_bytes < 1024.0 ^ 5)
  unit = "TB";
elseif (abs_bytes < 1024.0 ^ 6)
  unit = "PB";
elseif (abs_bytes < 1024.0 ^ 7)
  unit = "EB";
elseif (abs_bytes < 1024.0 ^ 8)
  unit = "ZB";
else
  unit = "YB";
endif
bytes = $convert_utils:convert(tostr(bytes, " bytes"), unit);
if (round)
  bytes = $math_utils:precision(bytes, 2);
endif
if (unit == "bytes" && bytes == 1.0)
  unit = "byte";
elseif (unit != "bytes")
  "For accuracy sake, make it clear we're working with binary units.";
  unit = tostr(unit[1], "i", unit[2..$]);
endif
return tostr(bytes, " ", unit);
