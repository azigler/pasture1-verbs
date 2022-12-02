#21:size_string   this none this rxd

"Copied from Roebare (#109000):size_string at Sat Nov 26 18:41:12 2005 PST";
size = args[1];
if (typeof(size) != INT)
  return E_INVARG;
endif
if (`!player:build_option("audit_float") ! ANY')
  "...use integers to determine a four-char string...";
  factor = 1000;
  threshold = {{1000, "B"}, {1000000, "K"}, {1000000000, "M"}};
  if (!size)
    return " ???";
  elseif (size < 0 || size > threshold[$][1])
    if (size < 0 || size > $maxint)
      return " >2G";
    else
      "...floats still required to factor over $maxint...";
      return tostr($string_utils:right(floatstr(tofloat(size) / 1000000000.0, 0), 3), "G");
    endif
  elseif (size < threshold[1][1] && `!player:build_option("audit_bytes") ! ANY')
    return " <1K";
  endif
  for entry in ($list_utils:slice(threshold, 1))
    $command_utils:suspend_if_needed(0);
    i = $list_utils:iassoc(entry, threshold);
    if (size == entry)
      size = "1";
      try
        unit = threshold[i + 1][2];
      except error (E_RANGE)
        unit = "G";
      endtry
      break;
    elseif (size < entry)
      size = tostr(size / (entry / factor));
      unit = threshold[i][2];
      break;
    endif
  endfor
  return tostr($string_utils:right(size, 3), unit);
else
  "...use floats to determine a six-char string...";
  size = tofloat(size);
  factor = 1024.0;
  "...be precise, `((1024.00 * 1024.00) * 1024.00) * 1024.00'...";
  threshold = {{1048576.0, "K"}, {1073741824.0, "M"}, {1099511627776.0, "G"}};
  if (!size)
    return "   ???";
  elseif (size < 0.0 || size > threshold[$][1])
    "...special handling for bad conversions & big numbers...";
    if (size < 0.0 || size > tofloat($maxint))
      return "   >2G";
    else
      return tostr($string_utils:right(floatstr(size / 1000000000.0, 1), 3), "G");
    endif
  endif
  for entry in ($list_utils:slice(threshold, 1))
    $command_utils:suspend_if_needed(0);
    i = $list_utils:iassoc(entry, threshold);
    if (size == entry)
      size = "1";
      try
        unit = threshold[i + 1][2];
      except error (E_RANGE)
        "...in another decade, maybe...";
        unit = "T";
      endtry
      break;
    elseif (size < entry)
      size = floatstr(size / (entry / factor), 1);
      unit = threshold[i][2];
      break;
    endif
  endfor
  return tostr($string_utils:right(size, 5), unit);
endif
"Rewritten by Roebare (#109000), 051119-26";
"With inspiration from Miral (#107983) and assistance from Diopter (#98842)";
"Byte & float display optional, per Nosredna (#2487), 051120-24";
