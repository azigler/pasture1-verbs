#93:_do_convert   this none this rxd

"THIS VERB IS NOT INTENDED FOR USER USAGE.";
":_do_convert is the workhorse of $convert_utils:convert and is based loosely upon the 'units' Perl script the ships with BSD Unix.";
"Essentially, it breaks the input up into values and units, attempts to break each unit down into elementary (basic) units, modifies the value as it goes, until it has no more input or can not convert a unit into a basic unit.";
instr = args[1];
units = this.basic_units_template;
value = 1.0;
top = 1;
"Ensure that the division mark is a spearate word.";
instr = $string_utils:substitute(instr, {{"/", " / "}});
while (instr)
  "Grab the next word to process";
  {first, instr} = $string_utils:first_word(instr);
  if (first == "/")
    "Now we're working with values under the division mark - units with negative exponents.";
    top = 1 - top;
    continue;
  elseif (match(first, "|"))
    "The word was a value expressed as a ratio. Compute the ratio and adjust the value accordingly.";
    value = this:_do_value(first, value, top);
    continue;
  elseif ($string_utils:is_integer(first) || $string_utils:is_float(first))
    "The word was a value. Adjust the accumulated value accordingly.";
    value = top ? value * tofloat(first) | value / tofloat(first);
    continue;
  elseif (match(first, "[0-9]$"))
    "The word ends with a digit, but isn't a value. It must be a powered unit. Expand it: cm3 => cm cm cm";
    subs = match(first, "%([a-zA-Z]+%)%([0-9]+%)");
    first = substitute("%1", subs);
    power = toint(substitute("%2", subs));
    while (power > 0)
      instr = first + " " + instr;
      power = power - 1;
    endwhile
    continue;
  else
    "Check to see if the word starts with one or more metric prefix and attempt to evaluate the prefix.";
    {first, value, top} = this:_try_metric_prefix(first, value, top);
    "Check to see if we have a basic unit. If so, adjust the apropriate unit count.";
    if (index = first in this.basic_units)
      units[index][2] = top ? units[index][2] + 1 | units[index][2] - 1;
      continue;
    elseif (prop = `this.(first) ! E_PROPNF => 0')
      "Check to see if this is a known unit. If so, convert it and adjust the value and units.";
      result = this:_do_convert(prop);
      value = top ? value * result[1] | value / result[1];
      for i in [1..length(units)]
        units[i][2] = top ? units[i][2] + result[2][i][2] | units[i][2] - result[2][i][2];
      endfor
      continue;
    elseif (first[$] == "s")
      "Check to see if this is a normal 's'-ending plural, and try to do the above checks again.";
      temp = first[1..$ - 1];
      if (index = temp in this.basic_units)
        units[index][2] = top ? units[index][2] + 1 | units[index][2] - 1;
        continue;
      elseif (prop = `this.(temp) ! E_PROPNF => 0')
        result = this:_do_convert(prop);
        value = top ? value * result[1] | value / result[1];
        for i in [1..length(units)]
          units[i][2] = top ? units[i][2] + result[2][i][2] | units[i][2] - result[2][i][2];
        endfor
        continue;
      endif
    endif
    "We were unable to find any conversion for the current word, so halt all operation and return 0.";
    return 0;
  endif
endwhile
"We were able to successfully convert each part of the input. Return the equivalent value and units.";
return {value, units};
