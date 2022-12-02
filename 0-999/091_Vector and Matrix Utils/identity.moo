#91:identity   this none this rxd

":identity(INT <size>) => Identity matrix (I) of dimensions <size> by <size>.";
"All elements of I are 0, except for the diagonal elements which are 1.";
"";
"The Identity Matrix has the unique property such that when another matrix is multiplied by it, the other matrix remains unchanged. This is similar to the number 1. a*1 = a. A * I = A, if the dimensions of I and A are the same.";
"";
n = args[1];
result = this:null(n, n);
for i in [1..n]
  result[i][i] = 1;
endfor
return result;
