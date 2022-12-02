#134:check_range   this none this xd

":check_range(value, range): check whether value falls within range";
"Where value is an int, and range is a list containing ints or lists consisting of two or three ints.";
"The range -1 acts as a wildcard, so the verb will always return true in this case.";
"Returns: 1 if value falls within range, 0 otherwise.";
{value, range} = args;
if (typeof(range) == INT)
  if (range == -1)
    return 1;
  elseif (range < -1 && value % abs(range) == 0)
    return 1;
  else
    range = {range};
  endif
endif
for r in (range)
  if (typeof(r) == INT && value == r)
    return 1;
  elseif (typeof(r) == LIST)
    if (length(r) == 2 && value >= r[1] && value <= r[2])
      return 1;
    elseif (length(r) == 3 && (value >= r[1] && value <= r[2] && (value - r[1]) % r[3] == 0))
      return 1;
    endif
  endif
endfor
"Last modified Thu Aug 31 08:10:21 2017 CDT by Jason Perino (#91@ThetaCore).";
