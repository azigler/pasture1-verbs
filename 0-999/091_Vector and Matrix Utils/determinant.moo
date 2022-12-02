#91:determinant   this none this rxd

":determinant(M) => NUM the determinant of the matrix.";
"";
"There are several properties of a matrix's determinant. Adding or subtracting a row or column from another row or colum of a matrix does not hange the value of its determinant. Multiplying a row or column of a matrix by a single scalar value has the effect of multiplying the matrix's determinant by the same scalar.";
"";
"However, the most dramatic use of determinants is in solving linear equations. For example, the solution to this system of equations:";
"";
"Ax1 + Bx2 + Cx3 = D";
"Ex1 + Fx2 + Gx3 = H";
"Ix1 + Jx2 + Kx3 = L";
"";
"is";
"";
"     1 |D B C|         1 |A D C|        1 |A B D|";
"x1 = - |H F G|    x2 = - |E H G|   x3 = - |E F H|";
"     Z |L J K|         Z |I L K|        Z |I J L|";
"";
"          |A B C|";
"where Z = |E F G|";
"          |I J K|";
"";
"or, in other words, x1, x2, and x3 are some determinant divided by Z, another determinant.";
"";
"Determinants are also used in computing the cross product of two vectors. See 'help $matrix_utils:cross_prod' for more info.";
"";
{mat} = args;
if (!this:is_square(mat))
  return raise("E_INVMAT", "Invalid Matrix Format");
elseif (this:dimensions(mat) == {1, 1})
  return mat[1][1];
elseif (this:dimensions(mat)[1] == 2)
  return mat[1][1] * mat[2][2] - mat[1][2] * mat[2][1];
else
  result = typeof(mat[1][1]) == INT ? 0 | 0.0;
  coeff = typeof(mat[1][1]) == INT ? 1 | 1.0;
  for n in [1..length(mat[1])]
    result = result + coeff * mat[1][n] * this:determinant(this:submatrix(1, n, mat));
    coeff = -coeff;
  endfor
  return result;
endif
"elseif dims == {1,1} lines are courtesy of Link (#122143).  21-Oct-05";
"Originated by Uther. Modified by Link (#122143) on 16-Nov-2005.";
