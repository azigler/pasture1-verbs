#20:triml   this none this rxd

":triml(string [, space]) -- remove leading spaces";
"";
"`space' should be a character (single-character string); it defaults to \" \".  Returns a copy of string with all leading copies of that character removed.  For example, $string_utils:triml(\"***foo***\", \"*\") => \"foo***\".";
{string, ?what = " "} = args;
m = match(string, tostr("[^", what, "]%|$"));
return string[m[1]..$];
