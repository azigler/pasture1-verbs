#91:submatrix   this none this rxd

":submatrix(i, j, M1) => M2, the matrix formed from deleting the ith row and jth column from M1.";
{i, j, mat} = args;
{k, l} = this:dimensions(mat);
result = {};
for m in [1..k]
  sub = {};
  for n in [1..l]
    if (m != i && n != j)
      sub = {@sub, mat[m][n]};
    endif
  endfor
  if (sub)
    result = {@result, sub};
  endif
endfor
return result;
