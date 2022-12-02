#55:max_length   this none this rx

":max_length(strings-or-lists[, default])";
"Return the maximum length of a set of strings or lists.";
"default is the minimum length that can be returned; 0 is a safe bet.";
max = args[2] || 0;
for item in (args[1])
  max = max(max, length(item));
endfor
return max;
