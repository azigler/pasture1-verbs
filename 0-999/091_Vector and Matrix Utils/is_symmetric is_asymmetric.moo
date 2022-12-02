#91:"is_symmetric is_asymmetric"   this none this rxd

":is_symmetric   (M) => 1 if M is a symmetric relation, -1 if asymmetric,";
"                       0 otherwise.";
":is_asymmetric does the same, but with 1 and -1 reversed.";
{mat} = args;
if (!this:is_square(mat))
  return raise("E_INVMAT", "Invalid Matrix Format");
endif
good = bad = 0;
for m in [1..len = length(mat)]
  for n in [m + 1..len]
    if (mat[m][n] == mat[n][m])
      good = 1;
    else
      bad = 1;
    endif
  endfor
endfor
return this:_relation_result(good, bad, verb[4] == "a");
