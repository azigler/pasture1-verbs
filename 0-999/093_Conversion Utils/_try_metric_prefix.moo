#93:_try_metric_prefix   this none this rxd

"THIS VERB IS NOT INTENDED FOR USER USAGE.";
":_try_metric_prefix runs through the metrix multipliers and tries to match them against the beginning of the input string. If successful, the given value is adjusted appropritately, and the input string is modified. The verb loops until there are no more prefix matches. (Hence, \"kilodecameter\" can be matched with only one verb call.";
"If anyone knows of other possibilities here, please let me know.";
{first, value, top} = args;
while (1)
  if (subs = match(first, "^yocto%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1e+24 | value * 1e+24;
    continue;
  endif
  if (subs = match(first, "^zepto%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1e+21 | value * 1e+21;
    continue;
  endif
  if (subs = match(first, "^atto%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1e+18 | value * 1e+18;
    continue;
  endif
  if (subs = match(first, "^femto%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1e+15 | value * 1e+15;
    continue;
  endif
  if (subs = match(first, "^pico%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1000000000000.0 | value * 1000000000000.0;
    continue;
  endif
  if (subs = match(first, "^nano%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1000000000.0 | value * 1000000000.0;
    continue;
  endif
  if (match(first, "^micron"))
    break;
  endif
  if (subs = match(first, "^micro%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1000000.0 | value * 1000000.0;
    continue;
  endif
  if (subs = match(first, "^milli%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 1000.0 | value * 1000.0;
    continue;
  endif
  if (subs = match(first, "^centi%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 100.0 | value * 100.0;
    continue;
  endif
  if (subs = match(first, "^deci%(.*%)"))
    first = substitute("%1", subs);
    value = top ? value / 10.0 | value * 10.0;
    continue;
  endif
  if (subs = match(first, "^%(deca%|deka%)%(.*%)"))
    first = substitute("%2", subs);
    value = !top ? value / 10.0 | value * 10.0;
    continue;
  endif
  if (subs = match(first, "^hecto%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 100.0 | value * 100.0;
    continue;
  endif
  if (subs = match(first, "^kilo%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1000.0 | value * 1000.0;
    continue;
  endif
  if (subs = match(first, "^mega%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1000000.0 | value * 1000000.0;
    continue;
  endif
  if (subs = match(first, "^giga%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1000000000.0 | value * 1000000000.0;
    continue;
  endif
  if (subs = match(first, "^tera%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1000000000000.0 | value * 1000000000000.0;
    continue;
  endif
  if (subs = match(first, "^peta%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1e+15 | value * 1e+15;
    continue;
  endif
  if (subs = match(first, "^exa%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1e+18 | value * 1e+18;
    continue;
  endif
  if (subs = match(first, "^zetta%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1e+21 | value * 1e+21;
    continue;
  endif
  if (subs = match(first, "^yotta%(.*%)"))
    first = substitute("%1", subs);
    value = !top ? value / 1e+24 | value * 1e+24;
    continue;
  endif
  break;
endwhile
return {first, value, top};
