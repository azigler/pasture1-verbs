#91:matrix_mul   this none this rxd

":matrix_mul(M1, M2) => MN such that MN[m][n] = the dot product of the mth row of M1 and the transpose of thenth column of M2.";
"";
"Matrix multiplication is the most common and complex operation performed on two matrices. First, matrices can only be multiplied if they are of compatible sizes. An i by j matrix can only be multiplied by a j by k matrix, and the results of this multiplication will be a matrix of size i by k. Each element in the resulting matrix is the dot product of a row from the first matrix and a column from the second matrix. (See 'help $matrix_utils:dot_prod'.)";
"";
{m1, m2} = args;
{i, j} = this:dimensions(m1);
{k, l} = this:dimensions(m2);
if (j != k || !this:is_matrix(m1) || !this:is_matrix(m2))
  return raise("E_INVMAT", "Invalid Matrix Format");
endif
result = {};
for m in [1..i]
  sub = {};
  for n in [1..l]
    $command_utils:suspend_if_needed(0);
    sub = {@sub, this:dot_prod(m1[m], this:column(m2, n))};
  endfor
  result = {@result, sub};
endfor
return result;
