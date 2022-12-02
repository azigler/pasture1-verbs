#91:inverse   this none this rxd

":inverse(M) => MN such that M * MN = I";
"";
"The inverse of a matrix is very similar to the reciprocal of a scalar number. If two numbers, A and B, equal 1 (the scalar identity number) when multiplied together (AB=1), then B is said the be the reciprocal of A, and A is the reciprocal of B. If A and B are matrices, and the result of multiplying them togeter is the Identity Matrix, then B is the inverse of A, and A is the inverse of B.";
"";
"Computing the inverse involves the solutions of several linear equations. Since linear equations can be easily solved with determinants, this is rather simple. See 'help $matrix_utils:determinant' for more on how determinants solve linear equations.";
"";
{mat} = args;
{i, j} = this:dimensions(mat);
if (tofloat(det = this:determinant(mat)) == 0.0)
  return raise("E_NOINV", "No Inverse Exists");
endif
result = {};
for k in [1..i]
  sub = {};
  for l in [1..j]
    sub = {@sub, (typeof(mat[1][1]) == INT ? -1 | -1.0) ^ (k + l) * this:determinant(this:submatrix(l, k, mat)) / det};
  endfor
  result = {@result, sub};
endfor
return result;
