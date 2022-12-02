#91:"is_transitive is_atransitive"   this none this rxd

":is_transitive  (M) => 1 if M is a transitive relation, -1 if atransitive,";
"                       0 otherwise.";
":is_atransitive does the same, but with 1 and -1 reversed.";
{mat} = args;
if (!this:is_square(mat))
  return raise("E_INVMAT", "Invalid Matrix Format");
endif
good = bad = 0;
for m in [1..len = length(mat)]
  for n in [1..len]
    if (mat[m][n])
      for l in [1..len]
        if (mat[n][l])
          if (mat[m][l])
            good = 1;
          else
            bad = 1;
          endif
        endif
      endfor
    endif
  endfor
endfor
return this:_relation_result(good, bad, verb[4] == "a");
