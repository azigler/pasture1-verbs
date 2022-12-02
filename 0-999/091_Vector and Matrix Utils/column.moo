#91:column   this none this rxd

":column(M, INT <n>) => LIST the nth column of M.";
{mat, i} = args;
j = this:dimensions(mat)[1];
result = {};
for m in [1..j]
  result = {@result, mat[m][i]};
  $command_utils:suspend_if_needed(0);
endfor
return result;
