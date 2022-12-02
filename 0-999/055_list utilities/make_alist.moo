#55:make_alist   this none this rxd

":make_alist(lists[, pad])";
"Make an alist out of n parallel lists (basically a matrix transpose).";
"If the lists are of uneven length, fill the remaining tuples with pad (defaults to 0).";
alist = {};
pad = length(args) > 1 ? args[2] | 0;
for i in [1..$list_utils:max_length(args[1])]
  tuple = {};
  for l in (args[1])
    tuple = {@tuple, i > length(l) ? pad | l[i]};
  endfor
  alist = {@alist, tuple};
endfor
return alist;
