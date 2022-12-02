#91:is_null   this none this rxd

":is_null(M) => 1 iff M is O.";
m = length(mat = args[1]);
if (!this:is_square(mat))
  return 0;
endif
for i in [1..m]
  for j in [1..m]
    if (mat[i][j] != 0)
      return 0;
    endif
  endfor
endfor
return 1;
