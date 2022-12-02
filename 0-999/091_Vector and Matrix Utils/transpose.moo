#91:transpose   this none this rxd

":transpose(Mmn) => Mnm";
"Transpose an m by n matrix into an n by m matrix by making the rows in the original the columns in the output.";
{mat} = args;
if (!this:is_matrix(mat))
  return raise("E_INVMAT", "Invalid Matrix Format");
endif
j = this:dimensions(mat)[2];
result = {};
for n in [1..j]
  result = {@result, this:column(mat, n)};
  $command_utils:suspend_if_needed(0);
endfor
return result;
