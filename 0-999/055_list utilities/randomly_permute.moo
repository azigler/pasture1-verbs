#55:randomly_permute   this none this rxd

":randomly_permute(list) => list with its elements randomly permuted";
"  each of the length(list)! possible permutations is equally likely";
plist = {};
for i in [1..length(ulist = args[1])]
  plist = listinsert(plist, ulist[i], random(i));
endfor
return plist;
