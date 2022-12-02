#20:trimr   this none this rxd

":trimr(string [, space]) -- remove trailing spaces";
"";
"`space' should be a character (single-character string); it defaults to \" \".  Returns a copy of string with all trailing copies of that character removed.  For example, $string_utils:trimr(\"***foo***\", \"*\") => \"***foo\".";
{string, ?what = " "} = args;
return string[1..rmatch(string, tostr("[^", what, "]%|^"))[2]];
