#55:remove_duplicates   this none this rxd

"remove_duplicates(list) => list as a set, i.e., all repeated elements removed.";
out = {};
for x in (args[1])
  out = setadd(out, x);
endfor
return out;
