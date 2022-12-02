#99:terminate_normal   this none this rxd

":terminate_normal (STR string) => STR <string> with a [[null]normal] code";
"tacked onto the end if there wasn't one";
if (!index(string = args[1], "["))
  return string;
endif
m = rmatch(string, this.terminate_regexp);
while (string && m && m[2] == length(string))
  string = string[1..m[1] - 1];
  m = rmatch(string, this.terminate_regexp);
endwhile
return string && string + (m && string[m[1]..m[2]] != "[normal]" ? "[normal]" | "");
