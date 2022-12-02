#20:english_list   this none this rxd

"Prints the argument (must be a list) as an english list, e.g. {1, 2, 3} is printed as \"1, 2, and 3\", and {1, 2} is printed as \"1 and 2\".";
"Optional arguments are treated as follows:";
"  Second argument is the string to use when the empty list is given.  The default is \"nothing\".";
"  Third argument is the string to use in place of \" and \".  A typical application might be to use \" or \" instead.";
"  Fourth argument is the string to use instead of a comma (and space).  Gary_Severn's deranged mind actually came up with an application for this.  You can ask him.";
"  Fifth argument is a string to use after the penultimate element before the \" and \".  The default is to have a comma without a space.";
{things, ?nothingstr = "nothing", ?andstr = " and ", ?commastr = ", ", ?finalcommastr = ","} = args;
nthings = length(things);
if (nthings == 0)
  return nothingstr;
elseif (nthings == 1)
  return tostr(things[1]);
elseif (nthings == 2)
  return tostr(things[1], andstr, things[2]);
else
  ret = "";
  for k in [1..nthings - 1]
    if (k == nthings - 1)
      commastr = finalcommastr;
    endif
    ret = tostr(ret, things[k], commastr);
  endfor
  return tostr(ret, andstr, things[nthings]);
endif
