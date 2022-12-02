#20:right(noansi)   this none this rxd

"$string_utils:right(string,width[,filler])";
"";
"Assures that <string> is at least <width> characters wide.  Returns <string> if it is at least that long, or else <string> preceded by enough filler to make it that wide. If <width> is negative and the length of <string> is greater than the absolute value of <width>, then <string> is cut off at <width> from the right.";
"";
"The <filler> is optional and defaults to \" \"; it controls what is used to fill the resulting string when it is too short.  The <filler> is replicated as many times as is necessary to fill the space in question.";
{text, len, ?fill = " "} = args;
abslen = abs(len);
out = tostr(text);
if ((lenout = length(out)) < abslen)
  return this:space(abslen - lenout, fill) + out;
else
  return len > 0 ? out | out[$ - abslen + 1..$];
endif
