#110:compare_version_range   this none this rxd

{client, server} = args;
{min1, max1} = client;
{min2, max2} = server;
min1 = typeof(min1) == STR ? this:parse_version(min1) | min1;
min2 = typeof(min2) == STR ? this:parse_version(min2) | min2;
max1 = typeof(max1) == STR ? this:parse_version(max1) | max1;
max2 = typeof(max2) == STR ? this:parse_version(max2) | max2;
if (!(min1 && min2 && max1 && max2))
  return;
else
  if (this:compare_version(max1, min2) <= 0 && this:compare_version(max2, min1) <= 0)
    if (this:compare_version(max1, max2) < 0)
      return max2;
    else
      return max1;
    endif
  endif
endif
return 0;
