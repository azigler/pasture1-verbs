#20:regexp_quote   this none this rxd

":regexp_quote(string)";
" => string with all of the regular expression special characters quoted with %";
string = args[1];
quoted = "";
while (m = rmatch(string, "[][$^.*+?%].*"))
  quoted = "%" + string[m[1]..m[2]] + quoted;
  string = string[1..m[1] - 1];
endwhile
return string + quoted;
