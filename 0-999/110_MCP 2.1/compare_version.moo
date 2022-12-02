#110:compare_version   this none this rxd

"-1 if v1 > v2, 0 if v1 = v2, 1 if v1 < v2";
{v1, v2} = args;
if (v1 == v2)
  return 0;
else
  {major1, minor1} = v1;
  {major2, minor2} = v2;
  if (major1 == major2)
    if (minor1 > minor2)
      return -1;
    else
      return 1;
    endif
  elseif (major1 > major2)
    return -1;
  else
    return 1;
  endif
endif
