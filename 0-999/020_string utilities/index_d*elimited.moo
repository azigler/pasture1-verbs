#20:index_d*elimited   this none this rxd

"index_delimited(string,target[,case_matters]) is just like the corresponding call to the builtin index() but instead only matches on occurences of target delimited by word boundaries (i.e., not preceded or followed by an alphanumeric)";
args[2] = "%(%W%|^%)" + $string_utils:regexp_quote(args[2]) + "%(%W%|$%)";
return (m = match(@args)) ? m[3][1][2] + 1 | 0;
