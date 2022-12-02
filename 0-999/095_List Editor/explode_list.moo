#95:explode_list   this none this rxd

":explode_list(indent,list) => corresponding list of strings to use.";
lines = {};
indent = $string_utils:space(args[1]);
for element in (args[2])
  if (typeof(element) == STR)
    lines = {@lines, indent + "\"" + element};
  else
    lines = {@lines, indent + $string_utils:print(element)};
  endif
endfor
return lines;
