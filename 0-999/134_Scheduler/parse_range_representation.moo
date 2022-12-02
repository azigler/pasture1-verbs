#134:parse_range_representation   this none this xd

":parse_range_representation(representation): Get a range of values from representation.";
"Representation should be a string containing a standard cron range.";
"Returns: range on success, blank list if representation is an invalid range representation.";
{rep} = args;
su = $string_utils;
range = {};
if (rep == "*")
  return -1;
elseif (length(rep) > 2 && rep[1..2] == "*/" && (n = toint(rep[3..$])) > 1)
  return n - n * 2;
endif
rep_list = su:explode(rep, ",");
for r in (rep_list)
  if ((i = index(r, "-")) > 1 && i < length(r))
    if ((j = index(r, "/")) && j < length(r) && toint(r[j + 1..$]) > 1)
      skip = toint(r[j + 1..$]);
      r = r[1..j - 1];
    else
      skip = 0;
    endif
    if (su:is_integer(r[1..i - 1]) && su:is_integer(r[i + 1..$]))
      min = toint(r[1..i - 1]);
      max = toint(r[i + 1..$]);
      range = {@range, skip ? {min, max, skip} | {min, max}};
    else
      return {};
    endif
  elseif (su:is_integer(r))
    range = {@range, toint(r)};
  else
    return {};
  endif
endfor
return range;
"Last modified Sat Sep  9 20:14:08 2017 CDT by Jason Perino (#91@ThetaCore).";
