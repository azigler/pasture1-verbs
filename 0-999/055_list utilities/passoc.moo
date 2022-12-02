#55:passoc   this none this rx

"passoc(key,list1,list2)";
"passoc() behaves rather similarly to assoc, with the exception that it's intended for";
"parallel lists.  given a key from list1, it returns a list containing the key and the";
"corresponding item from list2 (\"corresponding\", in the case of parallel lists, means";
"having the same index.)";
indx = args[1] in args[2];
if (indx)
  return {args[1], args[3][indx]};
else
  return {};
endif
