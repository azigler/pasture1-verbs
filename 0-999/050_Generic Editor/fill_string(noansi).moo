#50:fill_string(noansi)   this none this rxd

"fill(string [, width [, prefix]])";
"tries to cut <string> into substrings of length < <width> along word boundaries.  Prefix, if supplied, will be prefixed to the 2nd..last substrings.";
{string, ?width = 1 + player:linelen(), ?prefix = ""} = args;
width = width + 1;
if (width < 3 + length(prefix))
  return E_INVARG;
endif
string = "$" + string + " $";
len = length(string);
if (len <= width)
  last = len - 1;
  next = len;
else
  last = rindex(string[1..width], " ");
  if (last < (width + 1) / 2)
    last = width + index(string[width + 1..len], " ");
  endif
  next = last;
  while (string[next = next + 1] == " ")
  endwhile
endif
while (string[last = last - 1] == " ")
endwhile
ret = {string[2..last]};
width = width - length(prefix);
minlast = (width + 1) / 2;
while (next < len)
  string = "$" + string[next..len];
  len = len - next + 2;
  if (len <= width)
    last = len - 1;
    next = len;
  else
    last = rindex(string[1..width], " ");
    if (last < minlast)
      last = width + index(string[width + 1..len], " ");
    endif
    next = last;
    while (string[next = next + 1] == " ")
    endwhile
  endif
  while (string[last = last - 1] == " ")
  endwhile
  if (last > 1)
    ret = {@ret, prefix + string[2..last]};
  endif
endwhile
return ret;
