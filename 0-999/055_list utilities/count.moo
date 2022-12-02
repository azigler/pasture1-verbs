#55:count   this none this rxd

"$list_utils:count(item, list)";
"Returns the number of occurrences of item in list.";
{x, xlist} = args;
if (typeof(xlist) != LIST)
  return E_INVARG;
endif
counter = 0;
while (loc = x in xlist)
  counter = counter + 1;
  xlist = xlist[loc + 1..$];
endwhile
return counter;
