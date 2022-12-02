#20:to_value   this none this rxd

":to_value(string) tries to parse string as a value (i.e., object, number, string, error, or list thereof).";
"Returns {1,value} or {0,error_message} according as the attempt was successful or not.";
string = this:triml(args[1]);
if (string[1] == "[" || string[$] == "]")
  result = this:_tomap(string[1] == "[" ? string[2..$] | string);
  if (typeof(result[2]) != MAP)
    return {0, result[2]};
  else
    return {1, result[2]};
  endif
else
  result = this:_tolist(string = args[1] + "}");
  if (result[1] && result[1] != $string_utils:space(result[1]))
    return {0, tostr("after char ", length(string) - result[1], ":  ", result[2])};
  elseif (typeof(result[1]) == INT)
    return {0, "missing } or \""};
  elseif (length(result[2]) > 1)
    return {0, "comma unexpected."};
  elseif (result[2])
    return {1, typeof(result[2]) == LIST ? result[2][1] | result[2]};
  else
    return {0, "missing expression"};
  endif
endif
