#99:fill_string   this none this rxd

"fill(string,width[,prefix])";
"tries to cut <string> into substrings of length < <width> along word boundaries.  Prefix, if supplied, will be prefixed to the 2nd..last substrings.";
if (length(args) < 2)
  width = 2 + player:linelen();
  prefix = "";
else
  width = args[2] + 1;
  prefix = {@args, ""}[3];
endif
if (width < 3 + length(prefix))
  return E_INVARG;
endif
string = "$" + args[1] + " $";
len = this:length(string);
if (len <= width)
  last = len - 1;
  next = len;
else
  last = this:rindex(this:cutoff(string, 1, width), " ");
  if (last < (width + 1) / 2)
    last = width + this:index(this:cutoff(string, width + 1, "$", 1), " ");
  endif
  next = last;
  while (string[next = next + 1] == " ")
  endwhile
endif
while (string[last = last - 1] == " ")
endwhile
ret = {this:cutoff(string, 2, last)};
width = width - length(prefix);
minlast = (width + 1) / 2;
while (next < len)
  string = this:cutoff_assign(string, 1, next - 1, "$");
  "string = \"$\" + string[next..len];";
  len = len - next + 2;
  if (len <= width)
    last = len - 1;
    next = len;
  else
    last = this:rindex(this:cutoff(string, 1, width), " ");
    if (last < minlast)
      last = width + this:index(this:cutoff(string, width + 1, "$", 1), " ");
    endif
    next = last;
    while (string[next = next + 1] == " ")
    endwhile
  endif
  while (string[last = last - 1] == " ")
  endwhile
  if (last > 1)
    ret = {@ret, prefix + this:cutoff(string, 2, last)};
  endif
endwhile
return ret;
