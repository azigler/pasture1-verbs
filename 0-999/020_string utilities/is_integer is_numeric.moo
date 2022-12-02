#20:"is_integer is_numeric"   this none this rxd

"Usage:  is_numeric(string)";
"        is_integer(string)";
"Is string numeric (composed of one or more digits possibly preceded by a minus sign)? This won't catch floating points.";
"Return true or false";
return match(args[1], "^ *[-+]?[0-9]+ *$");
digits = "1234567890";
if (!(string = args[1]))
  return 0;
endif
if (string[1] == "-")
  string = string[2..length(string)];
endif
for i in [1..length(string)]
  if (!index(digits, string[i]))
    return 0;
  endif
endfor
return 1;
