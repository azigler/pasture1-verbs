#20:"uppercase lowercase"   this none this rxd

"lowercase(string) -- returns a lowercase version of the string.";
"uppercase(string) -- returns the uppercase version of the string.";
string = args[1];
from = caps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
to = lower = "abcdefghijklmnopqrstuvwxyz";
if (verb == "uppercase")
  from = lower;
  to = caps;
endif
for i in [1..26]
  string = strsub(string, from[i], to[i], 1);
endfor
return string;
