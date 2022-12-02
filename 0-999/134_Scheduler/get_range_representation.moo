#134:get_range_representation   this none this xd

":get_range_representation(range): Get a string representation of range.";
{range} = args;
if (typeof(range) == INT)
  if (range == -1)
    return "*";
  elseif (range < -1)
    return "*/" + tostr(abs(range));
  else
    range = {range};
  endif
endif
rep = "";
for r in [1..length(range)]
  if (typeof(range[r]) == INT)
    rep = rep + tostr(range[r]) + (r < length(range) ? "," | "");
  elseif (typeof(range[r]) == LIST)
    rep = rep + (tostr(range[r][1]) + "-" + tostr(range[r][2]) + (length(range[r]) == 3 ? "/" + tostr(range[r][3]) | "")) + (r < length(range) ? "," | "");
  endif
endfor
return rep;
"Last modified Thu Aug 31 09:10:36 2017 CDT by Jason Perino (#91@ThetaCore).";
