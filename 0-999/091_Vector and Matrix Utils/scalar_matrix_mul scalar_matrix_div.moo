#91:"scalar_matrix_mul scalar_matrix_div"   this none this rxd

":scalar_matrix_add(S, M) => MN such that MN[m][n] = MN[m][n] + S...";
":scalar_matrix_sub(S, M) => MN such that MN[m][n] = MN[m][n] - S...";
":scalar_matrix_mul(S, M) => MN such that MN[m][n] = MN[m][n] * S...";
":scalar_matrix_div(S, M) => MN such that MN[m][n] = MN[m][n] / S...";
"Actually, arguments can be (S, M) or (M, S). Each element of M is augmented by S. S should be either an INT or a FLOAT, as appropriate to the values in M.";
"I can see a reason for wanting to do scalar/matrix multiplication or division, but addition and subtraction between matrix and scalar types is not done. I've included them here for novelty, and because it was easy enough to do.";
type = verb[$ - 2..$];
if (typeof(args[1]) == LIST)
  {mval, sval} = args;
else
  {sval, mval} = args;
endif
if (!this:is_matrix(mval))
  return raise("E_INVMAT", "Invalid Matrix Format");
endif
results = {};
if (typeof(mval[1][1] == LIST))
  for n in [1..length(mval)]
    results = {@results, this:(verb)(mval[n], sval)};
  endfor
else
  for n in [1..length(mval)]
    results = {@results, this:("scalar_vector_" + type)(mval[n], sval)};
  endfor
endif
return results;
