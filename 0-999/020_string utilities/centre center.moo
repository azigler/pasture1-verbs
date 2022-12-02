#20:"centre center"   this none this rxd

"$string_utils:center(string,width[,lfiller[,rfiller]])";
"";
"Assures that <string> is at least <width> characters wide.  Returns <string> if it is at least that long, or else <string> preceded and followed by enough filler to make it that wide.  If <width> is negative and the length of <string> is greater than the absolute value of <width>, then the <string> is cut off at <width>.";
"";
"The <lfiller> is optional and defaults to \" \"; it controls what is used to fill the left part of the resulting string when it is too short.  The <rfiller> is optional and defaults to the value of <lfiller>; it controls what is used to fill the right part of the resulting string when it is too short.  In both cases, the filler is replicated as many times as is necessary to fill the space in question.";
{text, len, ?lfill = " ", ?rfill = lfill} = args;
out = tostr(text);
abslen = abs(len);
if (length(out) < abslen)
  return this:space((abslen - length(out)) / 2, lfill) + out + this:space((abslen - length(out) + 1) / -2, rfill);
else
  return len > 0 ? out | out[1..abslen];
endif
