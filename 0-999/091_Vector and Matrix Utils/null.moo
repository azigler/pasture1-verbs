#91:null   this none this rxd

":null(INT <size>) => Null matrix (O) of dimensions <size> by <size>.";
"All elements of O are 0.";
"";
"The Null Matrix has the property that is equivalent to the number 0; it reduces the original matrix to itself. a * 0 = 0. A * N = N.";
"";
{m, ?n = m} = args;
result = {};
for i in [1..m]
  result = {@result, {}};
  for j in [1..n]
    result[i] = {@result[i], 0};
  endfor
endfor
return result;
