#33:from_string   this none this rxd

":from_string(string) => corresponding sequence or E_INVARG";
"  string should be a comma separated list of numbers and";
"  number..number ranges";
su = $string_utils;
if (!(words = su:explode(su:strip_chars(args[1], " "), ",")))
  return {};
endif
parts = {};
for word in (words)
  to = index(word, "..");
  if (!to && su:is_numeric(word))
    part = {toint(word), toint(word) + 1};
  elseif (to)
    if (to == 1)
      start = $minint;
    elseif (su:is_numeric(start = word[1..to - 1]))
      start = toint(start);
    else
      return E_INVARG;
    endif
    end = word[to + 2..length(word)];
    if (!end)
      part = {start};
    elseif (!su:is_numeric(end))
      return E_INVARG;
    elseif ((end = toint(end)) >= start)
      part = {start, end + 1};
    else
      part = {};
    endif
  else
    return E_INVARG;
  endif
  parts = {@parts, part};
endfor
return this:union(@parts);
