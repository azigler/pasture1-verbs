#20:group_number   this none this rxd

"$string_utils:group_number(INT n [, sep_char])";
"$string_utils:group_number(FLOAT n, [INT precision [, scientific [, sep_char]]])";
"";
"Converts N to a string, inserting commas (or copies of SEP_CHAR, if given) every three digits, counting from the right.  For example, $string_utils:group_number(1234567890) returns the string \"1,234,567,890\".";
"For floats, the arguements precision (defaulting to 4 in this verb) and scientific are the same as given in floatstr().";
if (typeof(args[1]) == INT)
  {n, ?comma = ","} = args;
  result = "";
  sign = n < 0 ? "-" | "";
  n = tostr(abs(n));
elseif (typeof(args[1]) == FLOAT)
  {n, ?prec = 4, ?scien = 0, ?comma = ","} = args;
  sign = n < 0.0 ? "-" | "";
  n = floatstr(abs(n), prec, scien);
  i = index(n, ".");
  result = n[i..$];
  n = n[1..i - 1];
else
  return E_INVARG;
endif
while ((len = length(n)) > 3)
  result = comma + n[len - 2..len] + result;
  n = n[1..len - 3];
endwhile
return sign + n + result;
"Code contributed by SunRay";
