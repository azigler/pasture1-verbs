#59:inside_quotes   this none this rxd

"See if the end of the string passed as args[1] ends 'inside' a doublequote.  Used by $code_utils:substitute.";
{string} = args;
quoted = 0;
while (i = index(string, "\""))
  if (!quoted || (i == 1 || string[i - 1] != "\\"))
    quoted = !quoted;
  endif
  string = string[i + 1..$];
endwhile
return quoted;
