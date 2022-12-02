#91:"is_reflexive is_areflexive"   this none this rxd

":is_reflexive   (M) => 1 if M is a reflexive relation, -1 if areflexive,";
"                       0 otherwise.";
":is_areflexive does the same, but with 1 and -1 reversed.";
{m} = args;
if (!this:is_square(m))
  return raise("E_INVMAT", "Invalid Matrix Format");
endif
good = bad = 0;
for n in [1..length(m)]
  if (!m[n][n])
    bad = 1;
  else
    good = 1;
  endif
endfor
return this:_relation_result(good, bad, verb[4] == "a");
