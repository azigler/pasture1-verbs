#99:left   this none this rxd

"$ansi_utils:left(string,width[,filler])";
"";
"Assures that <string> is at least <width> characters wide.  Returns <string> if it is at least that long, or else <string> followed by enough filler to make it that wide. If <width> is negative and the length of <string> is greater than the absolute value of <width>, then the <string> is cut off at <width>.";
"";
"The <filler> is optional and defaults to \" \"; it controls what is used to fill the resulting string when it is too short.  The <filler> is replicated as many times as is necessary to fill the space in question.";
return this:terminate_normal(z = (l = this:length(out = tostr(args[1]))) < (len = abs(args[2])) ? out + this:space(l - len, length(args) >= 3 && args[3] || " ") | (args[2] > 0 ? out | this:cutoff(out, 1, len)));
