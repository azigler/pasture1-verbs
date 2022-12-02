#91:"matrix_add matrix_sub"   this none this rxd

":matrix_add(M1 [, M2 ...]) => MN such that MN[m][n] = M1[m][n] + M2[m][n]...";
":matrix_sub(M1 [, M2 ...]) => MN such that MN[m][n] = M1[m][n] - M2[m][n]...";
"Matrices should all be of the same size.";
"";
"Matrix addition and subtraction is simply the addition or subtraction of the vectors contained in the matrices. See 'help $matrix_utils:vector:add' for more help.";
type = verb[$ - 2..$];
results = args[1];
if (typeof(results[1][1]) == LIST)
  for n in [1..length(results)]
    results[n] = this:(verb)(results[n], @$list_utils:slice(args[2..$], n));
  endfor
else
  for n in [1..length(results)]
    results[n] = this:("vector_" + type)(results[n], @$list_utils:slice(args[2..$], n));
  endfor
endif
return results;
