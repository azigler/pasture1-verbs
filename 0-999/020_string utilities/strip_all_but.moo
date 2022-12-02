#20:strip_all_but   this none this rxd

":strip_all_but(string,keep) => string with chars not in `keep' removed.";
"`keep' is used in match() so if it includes ], ^, or -,";
"] should be first, ^ should be other from first, and - should be last.";
string = args[1];
wanted = "[" + args[2] + "]+";
output = "";
while (m = match(string, wanted))
  output = output + string[m[1]..m[2]];
  string = string[m[2] + 1..$];
endwhile
return output;
