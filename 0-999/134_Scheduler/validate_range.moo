#134:validate_range   this none this xd

":validate_range(range, min, max): Make sure all elements within range are >= min and <= max.";
"A range of -1 is always considered valid.";
"Returns: 1 if range is valid, 0 otherwise.";
{range, min, max} = args;
if (typeof(range) != INT && typeof(range) != LIST)
  return;
elseif (typeof(range) == INT)
  if (range == -1)
    return 1;
  elseif (range < -1 && abs(range) <= max / 2)
    return 1;
  else
    range = {range};
  endif
endif
for r in (range)
  if (typeof(r) != INT && typeof(r) != LIST)
    return;
  elseif (typeof(r) == INT && (r < min || r > max))
    return;
  elseif (typeof(r) == LIST)
    if (length(r) < 2 || length(r) > 3)
      return;
    elseif (typeof(r[1]) != INT || typeof(r[2]) != INT || r[1] < min || r[1] > max || r[2] < min || r[2] > max || r[1] >= r[2])
      return;
    elseif (length(r) == 3 && (typeof(r[3]) != INT || r[3] < 2 || r[3] > max / 2))
      return;
    endif
  endif
endfor
return 1;
"Last modified Tue Sep  5 22:50:44 2017 CDT by Jason Perino (#91@ThetaCore).";
