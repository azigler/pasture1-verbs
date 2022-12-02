#20:adjust_column_lengths   this none this rxd

":adjust_column_lengths({lengths}) => Takes a list of numbers that are assumed to be column lengths. Then, if the sum";
"                                       of those lengths exceeds the player's linelength, beginning systematically lowering";
"                                      individual columns until we fit on their screen.";
{ret, ?increment = 5, ?player = player} = args;
variable_picker = 0;
len = length(ret);
iterations = 0;
linelen = player:linelen();
while (1)
  $sin(0);
  iterations = iterations + 1;
  if (iterations >= 500000)
    break;
  endif
  sum = 0;
  for x in (ret)
    sum = sum + x;
  endfor
  if (sum <= linelen)
    return ret;
  else
    variable_picker = variable_picker + 1;
    if (variable_picker > len)
      variable_picker = len;
    endif
    if (ret[variable_picker] - increment <= 4)
      continue;
    endif
  endif
  ret[variable_picker] = ret[variable_picker] - increment;
endwhile
return ret;
