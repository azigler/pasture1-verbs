#20:left(noansi)   this none this rxd

"$string_utils:left(string,width[,filler])";
"";
"Assures that <string> is at least <width> characters wide.  Returns <string> if it is at least that long, or else <string> followed by enough filler to make it that wide. If <width> is negative and the length of <string> is greater than the absolute value of <width>, then the <string> is cut off at <width>.";
"";
"The <filler> is optional and defaults to \" \"; it controls what is used to fill the resulting string when it is too short.  The <filler> is replicated as many times as is necessary to fill the space in question.";
{text, len, ?fill = " "} = args;
abslen = abs(len);
out = tostr(text);
if (length(out) < abslen)
  return out + this:space(length(out) - abslen, fill);
else
  return len > 0 ? out | out[1..abslen];
endif
