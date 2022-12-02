#99:"centre center"   this none this rxd

"$ansi_utils:center(string,width[,lfiller[,rfiller]])";
"";
"Assures that <string> is at least <width> characters wide.  Returns <string> if it is at least that long, or else <string> preceded and followed by enough filler to make it that wide.  If <width> is negative and the length of <string> is greater than the absolute value of <width>, then the <string> is cut off at <width>.";
"";
"The <lfiller> is optional and defaults to \" \"; it controls what is used to fill the left part of the resulting string when it is too short.  The <rfiller> is optional and defaults to the value of <lfiller>; it controls what is used to fill the right part of the resulting string when it is too short.  In both cases, the filler is replicated as many times as is necessary to fill the space in question.";
return this:terminate_normal((l = this:length(out = tostr(args[1]))) < (len = abs(args[2])) ? tostr(this:space((len - l) / 2, lfill = length(args) >= 3 && args[3] || " "), out, this:space((len - l + 1) / -2, length(args) >= 4 ? args[4] | lfill)) | (args[2] > 0 ? out | this:cutoff(out, 1, len)));
