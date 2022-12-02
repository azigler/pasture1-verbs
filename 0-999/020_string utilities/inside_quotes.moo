#20:inside_quotes   this none this rx

"Copied from Moo_tilities (#332):inside_quotes by Mooshie (#106469) Tue Dec 23 10:26:49 1997 PST";
"Usage: inside_quotes(STR)";
"Is the  end of the given string `inside' a doublequote?";
"Called from $code_utils:substitute.";
{string} = args;
quoted = 0;
while (i = index(string, "\""))
  if (!quoted || string[i - 1] != "\\")
    quoted = !quoted;
  endif
  string = string[i + 1..$];
endwhile
return quoted;
