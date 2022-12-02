#99:hr_to_code   this none this rxd

"$ansi_utils:hr_to_code(colorstr) - Converts a human readable color sequence to a properly formatted escape code.";
{colorstr} = args;
if (colorstr in {0, ""})
  return E_INVARG;
endif
if (colorstr[1] == "[")
  colorstr = colorstr[2..$ - 1];
endif
if (index(colorstr, "|"))
  ret = "";
  for x in ($string_utils:explode(colorstr, "|"))
    ret = ret + "[" + x + "]";
  endfor
else
  ret = "[" + colorstr + "]";
endif
return ret;
"Last modified 11/01/18 1:38 a.m. by Sinistral (#2)";
