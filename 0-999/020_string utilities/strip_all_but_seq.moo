#20:strip_all_but_seq   this none this rxd

":strip_all_but_seq(string, keep) => chars in string not in exact sequence of keep removed.";
":strip_all_but() works similarly, only it does not concern itself with the sequence, just the specified chars.";
string = args[1];
wanted = args[2];
output = "";
while (m = match(string, wanted))
  output = output + string[m[1]..m[2]];
  string = string[m[2] + 1..length(string)];
endwhile
return output;
